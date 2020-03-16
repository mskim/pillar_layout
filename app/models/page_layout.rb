# frozen_string_literal: true

# == Schema Information
#
# Table name: page_layouts
#
#  id                      :bigint           not null, primary key
#  ad_type                 :string
#  column                  :integer
#  doc_height              :float
#  doc_width               :float
#  grid_height             :float
#  grid_width              :float
#  gutter                  :float
#  layout                  :text
#  layout_with_pillar_path :text
#  like                    :integer
#  margin                  :float
#  page_type               :integer
#  pillar_count            :integer
#  row                     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

# page_type
# 1 first page only
# 2, 3,4,6,7,8,9,10 .. 22,23,24
# with specific page number
# 100 even page only
# 101 odd page only


class PageLayout < ApplicationRecord
  has_many :pillars, as: :page_ref
  has_one :ad
  before_create :init_page_layout
  after_create :create_pillars

  serialize :layout, Array
  serialize :layout_with_pillar_path, Array
  serialize :undo, Array
  include RectUtils

  def page_number
    page_type
  end

  def top_margin
    margin
  end

  def left_margin
    margin
  end

  def bottom_margin
    margin
  end

  def right_margin
    margin
  end

  def pillar_profile
    s = ''
    pillars.each do |p|
      s += p.column.to_s + '/'
    end
    s
  end

  def profile
    "#{column}_#{ad_type}_#{layout_with_pillar_path}"
  end

  # given new pillar, create or return new PageLayout with changed pillar
  def change_node_as_pillar(new_pillar)
    p = Pillar.find(new_pillar)
    new_pillary_layout = p.layout
    current_layout = layout.dup
    union_rect = union_rects(new_pillary_layout)
    matching = current_layout.select { |r| r == union_rect }
    if first_match = matching.first
      # fix PageLayout, it will parse nested array for pillar
      current_layout[current_layout.index(union_rect)] = new_pillary_layout

      # replace_position = current_layout.index(union_rect)
      # current_layout.delete_at(replace_position)
      # # above code replaces current rect with array of rects
      # # insertindg rects one by one as same level as rest, not array of rects
      # new_pillary_layout.each do |rect|
      #   current_layout.insert(replace_position, rect)
      # end
      PageLayout.where(page_type: page_type, ad_type: ad_type, layout: current_layout).first_or_create
    else
      puts 'match not found!!!!'
    end
  end

  # convert leaf node layout to layout_with_tag
  # tag is inserted at fifth element
  def layout2tag
    # first_level = layout.group_by{|l| [l[0], column]}
    layout_with_tag = []
    first_level = 1
    second_level = 1
    third_level = 1
    current_grid_x = 0
    current_grid_y = 0

    layout.each_with_index do |box, i|
      if box[0] == 0 && box[2] == column
        # first level box
        with_tag = box.dup
        with_tag << first_level.to_s
        layout_with_tag << with_tag
        first_level += 1
        second_level = 1
        third_level = 1
      elsif box[0] == 0
        # left most second level box
        # check if this is first of third level
        current_grid_y = box[1]
        if layout.length > i + 1 && layout[i + 1][1] != current_grid_y
          # puts "we have at left most third level box...."
          # do the third level start
          with_tag = box.dup
          with_tag << "#{first_level}_#{second_level}_1"
          layout_with_tag << with_tag
          third_level += 1
        elsif layout[i - 1][2] == box[2]
          with_tag = box.dup
          with_tag << "#{first_level}_#{second_level}_#{third_level}"
          layout_with_tag << with_tag
          third_level += 1
        else
          # puts "We have left most second level box"
          with_tag = box.dup
          with_tag << "#{first_level}_1"
          layout_with_tag << with_tag
          second_level += 1
        end
      elsif box[1] == layout[i - 1][1]
        # after left most second level box
        current_grid_y = box[1]
        if layout.length > i + 1 && layout[i + 1][1] != current_grid_y
          # puts "we have third level after left most ...."
          # do thir level start
          with_tag = box.dup
          with_tag << "#{first_level}_#{second_level}_#{third_level}"
          layout_with_tag << with_tag
          third_level += 1
        elsif layout[i - 1][2] == box[2]
          with_tag = box.dup
          with_tag << "#{first_level}_#{second_level}_#{third_level}"
          layout_with_tag << with_tag
          third_level += 1
        else
          with_tag = box.dup
          with_tag << "#{first_level}_#{second_level}"
          layout_with_tag << with_tag
          second_level += 1
        end
      elsif box[0] = layout[i - 1][0]
        # third level .... of second level box
        # puts "tag:#{"#{first_level}_#{second_level}_#{third_level}"}"
        with_tag = box.dup
        with_tag << "#{first_level}_#{second_level}_#{third_level}"
        layout_with_tag << with_tag
        third_level += 1
      end
    end
    layout_with_tag
  end

  def to_hash
    h = {}
    h[:column]            = column
    h[:row]               = row
    h[:column]            = column
    h[:box_count]         = box_count
    h[:layout_with_pillar_path] = leaf_node_layout_with_pillar_path
    h
  end

  def pillars_info
    root_layout_nodes.map(&:leaf_node_layout_with_pillar_path)
  end

  def path
    "#{Rails.root}/public/page_layout/#{id}"
  end

  def page_heading_margin_in_lines
    3
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      header = %w[page_type column ad_type layout]
      csv << header
      all.each do |item|
        csv << item.attributes.values_at(*header)
      end
    end
  end

  def self.save_csv
    csv_path = "#{Rails.root}/public/page_layout.csv"
    csv = PageLayout.to_csv
    File.open(csv_path, 'w') { |f| f.write csv }
  end

  def setup
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end

  def unselect_all_nodes
    layout_nodes.each do |node|
      node.unselect if node.selected?
    end
  end

  def leaf_layout_nodes
    layout_nodes.select(&:childless?)
  end

  def root_layout_nodes
    layout_nodes.select(&:root?)
  end

  # def pillars
  #   layout_nodes.select{|a| a.node_kind == 'pillar'}
  # end

  def story_count
    pillars.map(&:story_count).reduce(:+)
  end

  def save_page_layout
    layout = layout_nodes.map(&:leaf_node_layout)
    update(layout: layout)
    layout_with_tag = layout_nodes.map(&:leaf_node_layout_with_pillar_path)
    update(layout_with_pillar_path: layout_with_tag)
  end

  def create_pillar_from_layout
    layout.each_with_index do |item, i|
      # if item.first.class == String
      if item.class == String
        self.ad_type = item
        save
        # create_ad_box(item)
      # elsif item.first.class == Array
      #   create_pillar_layout_node(item, i + 1)
      # elsif item.first[4].class == Hash
      #   create_layout_node_with_overlap(layout:item)
      elsif item.length == 5
        Pillar.where(page_ref: self, grid_x: item[0], grid_y: item[1], column: item[2], row: item[3], order: i + 1, box_count: item[4]).first_or_create
      elsif item.length == 4
        Pillar.where(page_ref: self, grid_x: item[0], grid_y: item[1], column: item[2], row: item[3], order: i + 1, box_count: 1).first_or_create
      end
    end
  end

  def update_pillar_from_layout
    article_layouts = layout.select{|item| item.class == Array}
    if article_layouts.length > pillars.length
      # TODO
      # create new pillars
    elsif article_layouts.length == pillars.length
      layout_with_out_ad.each_with_index do |item, i|
        pipllar = pillars[i]
        pipllar.update_pillar(item)
      end
    else
      # TODO
      # delte some pillars
    end
  end

  def body_line_height
    grid_height / 7
  end

  def scale
    10
  end

  def doc_width
    1114.02
  end

  def doc_height
    1544.88
  end

  def doc_left_margin
    margin
  end

  def doc_top_margin
    margin
  end

  def heading_space
    if page_type == 1
      body_line_height * 10
    else
      body_line_height * 3
    end
  end

  def svg_width
    (doc_width - margin * 2) / scale
  end

  def svg_height
    (doc_height - margin * 2) / scale
  end

  def svg_grid_width
    svg_width / column
  end

  def svg_grid_height
    svg_height / 15
  end

  def to_svg
    svg = <<~EOF
      <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{svg_width} #{svg_height}' >
        <rect fill='white' x='0' y='0' width='#{svg_width}' height='#{svg_height}' />
        #{pillars_svg}
      </svg>
    EOF
  end

  def pillars_svg
    s = ''
    pillars.each do |pillar|
      pillar_x_offset = pillar.grid_x
      pillar_y_offset = pillar.grid_y
      pillar.layout_with_pillar_path.each do |r|
        s += "<rect fill='yellow' stroke='black' stroke-width='1'  x='#{(r[0] +  pillar_x_offset)* svg_grid_width}' y='#{(r[1] + pillar_y_offset)* svg_grid_height}' width='#{r[2] * svg_grid_width}' height='#{r[3] * svg_grid_height}' />\n"
      end
    end
    s
  end

  def page_heading_svg
    ''
  end

  # - undo is an array of array [tag, action]
  #     - actions are h,v,d for
  #       - h : horozontal_cut
  #       - v : vertical_cut
  #       - d : delete
  #     - [['1_1','h'], ['1_2','v']]
  def undo_layout
    return unless undo.empty?

    last_action = undo.last
    puts "last_action:#{last_action}"
    case last_action[1]
    when 'v'
    when 'h'
    end
  end

  def valid_nodes
    root_layout_nodes.select { |n| !n.node_kind == 'ad' || !n.column.nil? || !n.row.nil? || n.column != '0' || n.column != 0 || n.row != 0 }
  end

  # save unique pillar
  def save_pillar
    valid_nodes.each(&:save_pillar)
  end

  def save_page_template
    puts __method__
    # PageTemplate.where().first_or_create
  end

  private

  def set_pillar_count
    self.pillar_count = layout.length
  end

  def init_page_layout
    self.ad_type      = '광고없음' unless ad_type
    self.column       = 6 unless column
    self.margin       = 50 unless margin
    self.row          = 15
    self.doc_width    = 1114.02
    self.doc_height   = 1544.88
    self.grid_width   = ((doc_width - margin * 2) / column).round(3)
    self.grid_height  = ((doc_height - margin * 2) / row).round(3)
    true
  end

  def create_pillars
    create_pillar_from_layout
    update(pillar_count: pillars.count)
  end
end
