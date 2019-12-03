# == Schema Information
#
# Table name: page_layouts
#
#  id                :bigint           not null, primary key
#  doc_width         :float
#  doc_height        :float
#  ad_type           :string
#  page_type         :integer
#  column            :integer
#  pillar_count      :integer
#  row               :integer
#  grid_width        :float
#  grid_height       :float
#  grid_line_count   :integer
#  gutter            :float
#  margin            :float
#  layout            :text
#  layout_with_pillar_path :text
#  stars             :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# page_type
# 0 both odd or even page
# 1 first page only
# 2 even page only
# 3 odd page only

class PageLayout < ApplicationRecord
  has_many :pillars, :as =>:region
  has_one :ad
  before_create :init_page_layout
  after_create :create_pillars
  
  serialize :layout, Array
  serialize :layout_with_pillar_path, Array
  serialize :undo, Array
  include RectUtils

  def profile
    "#{column}_#{ad_type}_#{layout_with_pillar_path}"
  end
  # given new pillar, create or return new PageLayout with changed pillar
  def change_node_as_pillar(new_pillar)
    p = Pillar.find(new_pillar)
    new_pillary_layout = p.layout
    current_layout = layout.dup
    union_rect = union_rects(new_pillary_layout)
    matching = current_layout.select{|r| r==union_rect}
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
      PageLayout.where(page_type:page_type, ad_type:ad_type, layout:current_layout).first_or_create
    else
      puts "match not found!!!!"
    end
  end



  # convert leaf node layout to layout_with_tag
  # tag is inserted at fifth element 
  def layout2tag
    # first_level = layout.group_by{|l| [l[0], column]}
    layout_with_tag = []
    first_level   = 1
    second_level  = 1
    third_level   = 1
    current_grid_x = 0
    current_grid_y = 0

    layout.each_with_index do |box, i|
      if box[0] == 0 && box[2] == column
        #first level box
        with_tag = box.dup
        with_tag << "#{first_level}"
        layout_with_tag << with_tag
        first_level += 1
        second_level  = 1
        third_level   = 1
      elsif box[0] == 0 
        # left most second level box
        # check if this is first of third level
        current_grid_y  = box[1]
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
        current_grid_y  = box[1]
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
    h= {}
    h[:column]            = column
    h[:row]               = row
    h[:column]            = column
    h[:box_count]         = box_count
    h[:layout_with_pillar_path] = leaf_node_layout_with_pillar_path
    h
  end

  def pillars_info
    root_layout_nodes.map{|n| n.leaf_node_layout_with_pillar_path}
  end

  def pillar_map
    map = []
    tree_path = []
    rects = []
    pillars_info.each do |item|
      if item.class == Array
        tree_path << item.last.dup
        rects << item.dup
      else
        tree_path << item
        rects << item.dup
      end
    end
    map << tree_path
    map << rects
    map
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
    File.open(csv_path, 'w'){|f| f.write csv}
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
    layout_nodes.select{|a| a.childless?}
  end

  def root_layout_nodes
    layout_nodes.select{|a| a.root?}
  end

  # def pillars
  #   layout_nodes.select{|a| a.node_kind == 'pillar'}
  # end

  def story_count
    pillars.map{|p| p.story_count}.reduce(:+)
  end

  def save_page_layout
    layout = layout_nodes.map{|p| p.leaf_node_layout}
    update(layout:layout)
    layout_with_tag = layout_nodes.map{|p| p.leaf_node_layout_with_pillar_path}
    update(layout_with_pillar_path:layout_with_tag)
  end

  def create_pillar_from_layout
    layout.each_with_index do |item, i|
      if item.first.class == String
        self.ad_type = item
        self.save
        create_ad_box(item)
      # elsif item.first.class == Array
      #   create_pillar_layout_node(item, i + 1)
      # elsif item.first[4].class == Hash
      #   create_layout_node_with_overlap(layout:item)
      elsif item.length == 5
        Pillar.where(region: self, grid_x: item[0], grid_y: item[1], column: item[2], row: item[3], order: i + 1, box_count:item[4] ).first_or_create
      elsif item.length == 4
        Pillar.where(region: self, grid_x: item[0], grid_y: item[1], column: item[2], row: item[3], order: i + 1, box_count: 1).first_or_create
      end
    end
  end

  def create_layout_nodes_from_layout
    # layout_array = eval(layout)
    layout.each_with_index do |item, i|
      if item.first.class == String
        self.ad_type = item
        self.save
        create_ad_mode(item)
      elsif item.first.class == Array
        create_pillar_layout_node(item, i + 1)
      elsif item.first[4].class == Hash
        create_layout_node_with_overlap(layout:item)
      elsif item.length == 4
        create_leaf_layout_node(item, i + 1)
      elsif  item.length == 5 
        if item[4].class == Integer && item[4] >= 0
          create_node_with_children(item, i + 1)
        elsif item[4].class == String && item[4].gsub("h", "").to_i >= 0
          create_node_with_children(item, i + 1)
        end

      end
    end
    save_page_layout
    self
  end

  def create_node_with_children(layout, order)
    grid_x          = layout[0]
    grid_y          = layout[1]
    child_column    = layout[2]
    child_row       = layout[3]
    node = LayoutNode.where(page_layout_id:self.id, column:child_column, row: child_row, node_kind: 'pillar', order: order, grid_x:grid_x, grid_y:grid_y).first_or_create
    if layout[4].class == Integer
      children_count = layout[4] 
      node.create_children('vertical', children_count)
    elsif layout[4].class == String && layout[4] =~ /^h/ # h3
      children_count = layout[4].sub("h","").to_i 
      node.create_children('horizontal',children_count)
    end
  end

  def create_leaf_layout_node(layout, order)
    grid_x        = layout[0]
    grid_y        = layout[1]
    node_column  = layout[2]
    node_row     = layout[3]
    node = LayoutNode.create(page_layout_id:id, column:node_column, row: node_row, node_kind: 'article', order: order, grid_x:grid_x, grid_y:grid_y)
  end

  # overlaping child on top of currnt box, only one is allowed
  def create_layout_node_with_overlap(options={})
    # TODO
    # LayoutNode.where(page_layout_id:id, column:child_column, row: child_row, order: order, grid_x:grid_x, grid_y:grid_y).first_or_create
    # a.create_overlap
  end

  def create_ad_box(ad_type)

  end

  def create_ad_mode(ad_type)
    h = {page_layout_id:id, node_kind:'ad'}
    case ad_type
    when '전면광고'
      h[:grid_x]  = 0
      h[:grid_y]  = 0
      h[:column]  = column
      h[:row]     = 5
    when '3단통'
      h[:grid_x]  = 0
      h[:grid_y]  = 12
      h[:column]  = column
      h[:row]     = 5
    when '4단통'
      h[:grid_x]  = 0
      h[:grid_y]  = 11
      h[:column]  = column
      h[:row]     = 5
    when '5단통'
      h[:grid_x]  = 0
      h[:grid_y]  = 10
      h[:column]  = column
      h[:row]     = 5
    when '7단15'
      if page_type.odd?
        h[:grid_x]  = 4
        h[:grid_y]  = 8
        h[:column]  = 2
        h[:row]     = 7
      else
        h[:grid_x]  = 0
        h[:grid_y]  = 8
        h[:column]  = 2
        h[:row]     = 7
      end
    when '7단15_중' 
      h[:grid_x]  = 2
      h[:grid_y]  = 8
      h[:column]  = 2
      h[:row]     = 7
    when '9단21'
      if page_type.odd?
        h[:grid_x]  = 3
        h[:grid_y]  = 6
        h[:column]  = 4
        h[:row]     = 9
      else
        h[:grid_x]  = 0
        h[:grid_y]  = 6
        h[:column]  = 4
        h[:row]     = 9
      end
    when '9단21_홀'
      h[:grid_x]  = 3
      h[:grid_y]  = 6
      h[:column]  = 4
      h[:row]     = 9
    when '9단21_짝'
      h[:grid_x]  = 0
      h[:grid_y]  = 6
      h[:column]  = 4
      h[:row]     = 9
    when '광고없음'
      h[:grid_x]  = 0
      h[:grid_y]  = 0
      h[:column]  = 0
      h[:row]     = 0
    else
      h[:grid_x]  = 0
      h[:grid_y]  = 0
      h[:column]  = 0
      h[:row]     = 0
    end
    h[:tag]        = ad_type
    node = LayoutNode.where(h).first_or_create
  end

  def body_line_height
    grid_height/grid_line_count
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

  def svg_width
    (doc_width - margin*2)/scale
  end

  def svg_height
    (doc_height - margin*2)/scale
  end

  def svg_grid_width
    svg_width/column
  end

  def svg_grid_height
    svg_height/15
  end

  def to_svg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{svg_width} #{svg_height}' >
      <rect fill='gray' x='0' y='0' width='#{svg_width}' height='#{svg_height}' />
      #{pillars_svg}
    </svg>
    EOF
  end

  def pillars_svg
    s = ""
    pillars.each do |pillar|
      s += pillar.layout_svg
    end
    s
  end

  def layout_node_svg
    s = ""
    s += page_heading_svg if page_type == 1
    leaf_layout_nodes.each do |node|
      s += node.box_svg
    end
    s
  end

  def page_heading_svg
    ""
  end

 
  # - undo is an array of array [tag, action]
  #     - actions are h,v,d for 
  #       - h : horozontal_cut
  #       - v : vertical_cut
  #       - d : delete
  #     - [['1_1','h'], ['1_2','v']]
  def undo_layout
    return if undo.length > 0
    last_action = undo.last
    puts "last_action:#{last_action}"
    case last_action[1]
    when 'v'
    when 'h'
    else
    end
  end

  def valid_nodes
    root_layout_nodes.select{|n| !n.node_kind=="ad" || !n.column.nil? || !n.row.nil? || n.column != '0' || n.column != 0 || n.row != 0}
  end

  # save unique pillar
  def save_pillar
    valid_nodes.each do |node|
      node.save_pillar
    end
  end

  def save_page_template
    puts __method__
    # PageTemplate.where().first_or_create
  end

  private

  def set_pillar_count
    self.pillar_count      = layout.length
  end

  def init_page_layout
    self.ad_type      = '광고없음' unless ad_type
    self.column       = 6 unless column
    self.margin       = 50 unless margin
    self.row          = 15
    self.doc_width    = 1114.02
    self.doc_height   = 1544.88
    self.grid_width   = ((doc_width - margin*2)/column).round(3)
    self.grid_height  = ((doc_height - margin*2)/row).round(3)
    true
  end
  
  def create_pillars
    create_pillar_from_layout
    update(pillar_count: pillars.count)
  end
end
