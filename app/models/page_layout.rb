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
#  pillars                 :text
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
  has_one :ad
  before_create :init_page_layout
  after_create :create_pillars

  # serialize :layout, Array
  serialize :layout_with_pillar_path, Array
  serialize :pillars, Array # array of pillar info Hash
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
      s += p[:column].to_s + '/'
    end
    s
  end

  def profile
    "#{column}_#{ad_type}_#{layout_with_pillar_path}"
  end
  
  def to_hash
    h = {}
    h[:column]            = column
    h[:row]               = row
    h[:column]            = column
    h[:box_count]         = box_count
    h[:layout_with_pillar_path] = layout_with_pillar_path
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
      header = %w[page_type column layout]
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
    pillars.select{|p| p.class == Array}.length
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
    pillar_colors_array = [ 'yellow','red', 'blue',  'green',   'purple']
    s = ''
    pillars.each_with_index do |pillar, i|
      fill_color = pillar_colors_array[i]
      pillar_x_offset = pillar[:grid_x]
      pillar_y_offset = pillar[:grid_y]
      box_count       = pillar[:box_count]
      x_position      = pillar_x_offset
      y_position      = pillar_y_offset
      box_width       = pillar[:column]
      box_height      = pillar[:row]/box_count.to_f
      box_count.times do |j|
        s += "<rect fill='#{fill_color}' stroke='black' stroke-width='2' opacity='0.3' x='#{(pillar_x_offset)*svg_grid_width}' y='#{y_position*svg_grid_height}' width='#{box_width * svg_grid_width}' height='#{box_height * svg_grid_height}' />\n"
        y_position += box_height
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

  def layout_array
    YAML::load(layout)
  end

  # h[:grid_x] = item[0]
  # h[:grid_y] = item[1]
  # h[:column] = item[2]
  # h[:row]    = item[3]
  # h[:box_count]  = item[4]
  def update_layout_with_pillar_path
    layout_with_pillar_path = []
    pillars.each do |pillar|
      row = pillar[:row]
      story_count = pillar[:box_count]
      pillar_boxes = []
      box_height = row/story_count
      remainer = row % story_count
      y_position = 0
      story_count.times do |i|
        box = []
        box[0] = 0
        box[1] = y_position
        box[2] = pillar[:column]
        box[3] = box_height
        box[3] += 1 if i < remainer # add remaining height at the top
        box[4] = "#{i+1}"
        pillar_boxes << box
        y_position += box[3]
      end
      layout_with_pillar_path += pillar_boxes
    end
    update(layout_with_pillar_path:layout_with_pillar_path)
    layout_with_pillar_path
  end

  def create_pillar_from_layout
    pillars_array = []
    layout_array.each_with_index do |item, i|
      # if item.first.class == String
      if item.class == String
        self.ad_type = item
        save
      elsif item.length == 5
        h = {}
        h[:grid_x] = item[0]
        h[:grid_y] = item[1]
        h[:column] = item[2]
        h[:row]    = item[3]
        h[:box_count]  = item[4]
        h[:order]  = i + 1
        pillars_array << h
      elsif item.length == 4
        h = {}
        h[:grid_x] = item[0]
        h[:grid_y] = item[1]
        h[:column] = item[2]
        h[:row]    = item[3]
        h[:box_count]  = 1
        h[:order]  = i + 1
        pillars_array << h
      end
    end
    update(pillars:pillars_array, pillar_count:pillars_array.length)

  end

  private

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
    update_layout_with_pillar_path
  end
end
