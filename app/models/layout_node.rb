# == Schema Information
#
# Table name: layout_nodes
#
#  id                      :bigint           not null, primary key
#  actions                 :text
#  ancestry                :string
#  box_count               :integer
#  column                  :integer
#  direction               :string
#  grid_x                  :integer
#  grid_y                  :integer
#  layout_with_pillar_path :text
#  node_kind               :string
#  order                   :integer
#  profile                 :string
#  row                     :integer
#  selected                :boolean
#  tag                     :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  pillar_id               :bigint
#
# Indexes
#
#  index_layout_nodes_on_pillar_id  (pillar_id)
#

# layout_with_pillar_path
# a Array of node array [x,y,width,height, ancestry] sorted by by order
class LayoutNode < ApplicationRecord
  belongs_to :pillar, optional: true
  before_create :init_layout_node
  has_ancestry
  serialize :actions, Array
  serialize :layout, Array
  serialize :layout_with_pillar_path, Array
  scope :root_node, -> { where("ancestry" => nil) }

  def self.update_layout_with_pillar_path
    LayoutNode.select{|n| n.root?}.each do |n|
      n.update_layout_with_pillar_path
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      header = %w[column row actions]
      csv << header
      all.each do |item|
        csv << item.attributes.values_at(*header)
      end
    end
  end

  def update_layout_with_pillar_path
    if root?
      result = [grid_x,grid_y, column, row, "1"]
    else
      result = leaf_node_layout_with_pillar_path
    end
    update(layout_with_pillar_path: result)
    result
  end


  def update_after_split
    new_layout_with_pillar_path = leaf_node_layout_with_pillar_path
    update(layout_with_pillar_path: new_layout_with_pillar_path)
  end

  def to_hash
    h= {}
    h[:column]            = column
    h[:row]               = row
    h[:box_count]             = box_count
    h[:layout_with_pillar_path] = leaf_node_layout_with_pillar_path
    h
  end

  # array of leaf node paths
  def pillar_path_array
    layout_with_pillar_path.map{|e| e[4]}
  end

  def max_column
    grid_x + column
  end

  def max_row
    grid_y + row
  end

  def tree_path
    node_path = order.to_s
    if parent
      if parent.is_root?
        node_path
      else
        parent.tree_path + "_#{node_path}" 
      end
    else
      node_path
    end
  end

  def children_count
    children.length
  end

  def h_dividable? 
    true if row > 1
  end

  def v_dividable? 
    true if column > 1 
  end

  def v_spitable? 
    true if row > 1
  end

  def h_spitable?
    true if column > 1
  end

  def is_leaf?
    !has_children?
  end

  def expandable?
    true
  end

  def can_remove?
    false
  end

  def can_undo?
    false
  end

  def has_horizontal_sibling?
    parent && parent.direction == 'horizontal' && parent.children_count > 1
  end

  def has_vertical_sibling?
    parent && parent.direction == 'vertical' && parent.children_count > 1
  end

  def select
    # page_layout.unselect_all_nodes
    update(selected: true)
  end

  def select_parent
    parent.select if parent
  end

  def unselect
    update(selected: false)
  end

  def selected?
    selected == true
  end

  def h_divide_times(action)
    count = 1
    count = action.split("*")[1].to_i
    count.times do |i|
      result = h_divide
      break unless result 
    end
  end

  def h_divide
    unless h_dividable?
      puts 'no room to spilt vertically!!!'
      return false
    end
    if direction == 'vertical' && children_count > 0
      result = add_v_child
      return result
    end
    update(direction: 'vertical', selected: false)
    first_child_row = row/2
    secomd_child_row = first_child_row
    first_child_row += 1 if row.odd?
    first   = LayoutNode.create!(parent:self, node_kind:'article', grid_x: grid_x, grid_y: grid_y, column:column, row: first_child_row, order: 1, box_count: 1, actions: [])
    second  = LayoutNode.create!(parent:self, node_kind:'article', grid_x: grid_x , grid_y: grid_y + first_child_row, column:column, row: secomd_child_row, order: 2, box_count: 1, actions: [])
    true
  end

  def undo_h_divide(undo_info)
  end

  def v_divide_times(action)
    count = action.split("*")[1].to_i
    count.times do
      result = v_divide
      break unless result 
    end
  end

  def v_divide
    unless  v_dividable?
      puts 'no room to spilt horizontally!!!'
      return false
    end
    if direction == 'horizontal' && children_count > 0
      result = add_h_child
      return result
    end

    update(direction: 'horizontal', selected: false)
    first_child_column = column/2
    second_child_column = first_child_column
    first_child_column += 1 if column.odd?
    LayoutNode.create(parent:self, node_kind:'article', grid_x: grid_x, grid_y: grid_y, column:first_child_column, row: row, order: 1, box_count: 1)
    LayoutNode.create(parent:self, node_kind:'article', grid_x: grid_x + first_child_column, grid_y: grid_y, column:second_child_column, row: row, order: 2, box_count: 1)
    true
  end

  def v_divide_at(position)
    update(direction: 'horizontal', selected: false)
    first_child_column    = position
    second_child_column   = column - position
    if position < 0
      first_child_column  = column + position
      second_child_column = position
    end
    LayoutNode.create(parent:self, node_kind:'article', grid_x: grid_x, grid_y: grid_y, column:first_child_column, row: row, order: 1, box_count: 1)
    LayoutNode.create(parent:self, node_kind:'article', grid_x: grid_x + first_child_column, grid_y: grid_y, column:second_child_column, row: row, order: 2, box_count: 1)
    
  end

  def undo_v_divide(undo_info)

  end

  def add_h_child
    direction = 'horizontal'
    would_be_children_count = children_count + 1
    if would_be_children_count > column
      puts "children_count is greater than currnt column!!!"
      return false
    end
    child_column           = column/would_be_children_count
    child_column_remainder = column % would_be_children_count
    # update column for current children
    child_row   = row
    current_grid_x = grid_x
    ordered_children = children.sort_by{|n| n.order}
    ordered_children.each_with_index do |child, i|
      if i < child_column_remainder
        child.update(grid_x: current_grid_x, column: child_column + 1)
        current_grid_x += child_column + 1
      else
        child.update(grid_x: current_grid_x, column: child_column)
        current_grid_x += child_column
      end
    end
    grid_x = ordered_children.last.max_column
    LayoutNode.create(parent:self, node_kind:'article', grid_x: grid_x, grid_y: grid_y, column:child_column, row: child_row, order: would_be_children_count, box_count: 1)
    true
  end

  def undo_add_h_child(undo_info)
    
  end

  def add_v_child
    would_be_children_count = children_count + 1
    if would_be_children_count >  row
      puts "children_count is greater than currnt row!!!"
      return false
    end
    child_row             = row/would_be_children_count
    child_row_remainder   = row % would_be_children_count
    child_column   = column
    current_grid_y = grid_y
    ordered_children = children.sort_by{|n| n.order}
    ordered_children.each_with_index do |child, i|
      if i < child_row_remainder
        child.update(grid_y: current_grid_y, row: child_row + 1)
        current_grid_y += child_row + 1
      else
        child.update(grid_y: current_grid_y, row: child_row)
        current_grid_y += child_row
      end
    end
    grid_y = ordered_children.last.max_row
    LayoutNode.create(parent:self, node_kind:'article', grid_x: grid_x, grid_y: grid_y, column:child_column, row: child_row, order: would_be_children_count, box_count: 1)
    
    true
  end

  def undo_add_v_child(undo_info)
  end

  def remove_last_child
    return if children_count <= 1
    if children_count == 2
      last_child = children.last.destroy
      last_child = children.last.destroy
    else
      last_child = children.last
      last_child.destroy 
      relayout_children
    end
  end

  def undo_remove_last_child(undo_info)
  end

  def relayout_children
    currnt_children_count   = children.length
    child_row_remainder     = 0
    child_column_remainder  = 0
    if direction == 'vertical'
      child_row             = row/currnt_children_count
      child_row_remainder   = row % currnt_children_count
      child_column   = column
      current_grid_y = self.grid_y
      grid_x         = self.grid_x
      children.sort_by{|n| n.order}.each_with_index do |child, i|
        child.row    = child_row
        child.grid_y = current_grid_y
        if i < child_row_remainder
          child.update(grid_y:current_grid_y,  row: child_row + 1)
          current_grid_y += child_row + 1
        else
          child.update(grid_y:current_grid_y,  row: child_row)
          current_grid_y += child_row
        end
      end
    else
      # update column for current children
      child_column           = column/currnt_children_count
      child_column_remainder = column % currnt_children_count
      child_row   = row
      current_grid_x = self.grid_x
      children.sort_by{|n| n.order}.each_with_index do |child, i|
        if i < child_column_remainder
          child.update(grid_x:current_grid_x, column: child_column + 1 )
          current_grid_x += child_column + 1
        else
          child.update(grid_x:current_grid_x, column: child_column)
          current_grid_x += child_column
        end
      end
    end
  end

  def create_children(direction, count)
    return unless count > 0
    child_grid_x = self.grid_x
    child_grid_y = self.grid_y

    # grid_x        = 0
    # grid_y        = 0
    child_column  = column
    child_row     = row
    child_row_remainder    = 0
    child_column_remainder = 0
    
    if direction == 'vertical'
      if count >=  row
        puts "count is greater than currnt row!!!"
        return 
      end
      child_row            = row/count
      # sum of children's columns/row could be shorter than the parent's space!
      #  if we have ramainer space(row % count) > 0,   increase child_row by 1 from top/left until we fill up the ramainer space
      child_row_remainder  = row % count
    else
      if count >= column
        puts "count is greater than currnt column!!!"
        return 
      end
      child_column            = column/count
      # sum of children's columns/row could be shorter than the parent's space!
      #  if we have ramainer space(column % count) > 0,   increase columns/row by 1 from top/left until we fill up the ramainer space
      child_column_remainder  = column % count
    end
    count.times do |i|
      if direction == 'vertical'
        if i < child_row_remainder
          #  if we have ramainer child_row_remainder < i,   increase child_row by 1 from top until we fill up the ramainer space
          new_child = LayoutNode.create(parent: self, node_kind:'article', column:child_column, row: child_row + 1, order: i + 1, grid_x:grid_x, grid_y:child_grid_y)
          child_grid_y += child_row + 1
        else
          new_child = LayoutNode.create(parent: self, node_kind:'article', column:child_column, row: child_row, order: i + 1, grid_x:grid_x, grid_y:child_grid_y)
          child_grid_y += child_row
        end
      else
        if i < child_column_remainder
          #  if we have ramainer child_column_remainder < i,   increase child_column by 1 from left until we fill up the ramainer space
          new_child = LayoutNode.create(parent: self, node_kind:'article', column:child_column + 1, row: child_row, order: i + 1, grid_x:child_grid_x, grid_y:child_grid_y)
          child_grid_x += child_column + 1
        else
          new_child = LayoutNode.create(parent: self, node_kind:'article', column:child_column, row: child_row, order: i + 1, grid_x:child_grid_x, grid_y:child_grid_y)
          child_grid_x += child_column
        end
      end
    end
    update(direction: direction)
    self
  end

  # overlaping child on top of currnt box, only one is allowed
  def create_overlap(options={})
    if column < 2 || row < 2
      puts "box too small to create overlap"
      return 
    end
    child_position = options[:position] || 9
    child_column  = options[:column] || column/2
    child_row     = options[:row] || row/2
    case child_position
    when 1
      grid_x = 0
      grid_y = 0
    when 2
      grid_x = (column - child_column)/2
      grid_y = 0
    when 3
      grid_x = (column - child_column)
      grid_y = 0
    when 7, 4
      grid_x = 0
      grid_y = (row - child_row)
    when 8, 5
      grid_x = (column - child_column)/2
      grid_y = (row - child_row)
    when 9, 6
      grid_x = (column - child_column)
      grid_y = (row - child_row)
    end
    LayoutNode.create(parent: self, node_kind: 'overlap', column:child_column, row: child_row, order: 1, grid_x:grid_x, grid_y:grid_y, position:child_position)
  end

  def grid_rect
    [grid_x, grid_y, column, row]
  end

  def x
    # grid_x*page_layout.svg_grid_width
  end

  def y
    # grid_y*page_layout.svg_grid_height
  end

  def width
    # column*page_layout.svg_grid_width
  end

  def height
    # row*page_layout.svg_grid_height
  end

  def translated_x
    if parent
      parent.translated_x + x 
    else
      x
    end
  end

  def translated_y
    if parent
      parent.translated_y + y
    else
      y
    end
  end

  def ad_type
    # page_layout.ad_type
  end

  # this is used for editing, supports selected box with red color
  def box_svg
    if node_kind == 'ad'
      svg =   "<rect class='rectfill' stroke='black' stroke-width='1' fill-opacity='0.0' x='#{translated_x}' y='#{translated_y}' width='#{width}' height='#{height}' />\n"
      svg += "<text fill='yellow' font-size='#{8}' x='#{translated_x + 4}'y='#{translated_y + 8}' stroke-width='0' >#{ad_type}  </text>"
      svg += "<a xlink:href='/layout_nodes/#{id}'><rect class='rectfill' stroke='black' stroke-width='1' fill-opacity='0.0' x='#{translated_x}' y='#{translated_y}' width='#{width}' height='#{height}' /></a>\n"
    else
      if selected?
        svg = "<rect fill='red'  x='#{x}' y='#{y}' width='#{width}' height='#{height}' />\n"
      else
        svg = "<rect fill='white'  x='#{x}' y='#{y}' width='#{width}' height='#{height}' />\n"
      end
      if column == 1
        svg += "<text fill='gray' font-size='#{4}' x='#{x + 2}'y='#{y + 8}' stroke-width='0' >#{tree_path}  </text>"
      else
        svg += "<text fill='gray' font-size='#{8}' x='#{x + 4}'y='#{y + 8}' stroke-width='0' >#{tree_path}  </text>"
      end
        svg += "<a xlink:href='/layout_nodes/#{id}/select'><rect class='rectfill' stroke='black' stroke-width='1' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
    end
  end


  def h_scale
    10
  end

  def v_scale
    5
  end

  def to_svg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{column*h_scale} #{row*v_scale}' >
      <rect fill='yellow' x='0' y='0' width='#{column*h_scale}' height='#{row*v_scale}' />
      #{layout_svg}
    </svg>
    EOF
  end

  # show selected svg within page  
  def page_embeded_svg(page_colum, column_offset, row_offset)
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{page_colum*h_scale} #{15*v_scale}' >
      <rect fill='gray' x='0' y='0' width='#{page_colum*h_scale}' height='#{15*v_scale}' />
      <rect fill='yellow' x='#{column_offset*h_scale}' y='#{row_offset*v_scale}' width='#{column*h_scale}' height='#{row*v_scale}' />
      #{layout_svg(column_offset, row_offset)}
    </svg>
    EOF

  end
  
  def layout_svg(column_offset, row_offset)
    s = ""
    layout_array = leaf_node_layout
    layout_array.each do |rect|
      if rect.nil?
        next 
        puts "+++++++ problem at id:#{id}"
      end
      s += "<rect class='rectfill' stroke='black' stroke-width='1' fill-opacity='0.0' x='#{(column_offset + rect[0])*h_scale}' y='#{(row_offset + rect[1])*v_scale}' width='#{rect[2]*h_scale}' height='#{rect[3]*v_scale}' />\n"
    end
    s
  end

  def leaf_nodes
    descendants.select{|n| n.is_leaf?}
  end

  def node_area
    if parent
      [grid_x - root.grid_x, grid_y - root.grid_y, column, row]
    else
      [grid_x, grid_y, column, row]
    end
  end

  def node_area_with_tree_path
    if parent
      [grid_x - root.grid_x, grid_y - root.grid_y, column, row, tree_path]    
    else
      [grid_x, grid_y, column, row, tree_path]
    end
  end

  def leaf_node_layout_with_pillar_path
    # keys are tags and values are article rect
    if node_kind == 'ad'
      ad_type
    elsif children_count == 0
      [grid_x,grid_y,column, row, order]
    else
      leaf_nodes.sort_by{|n| [n.grid_y, n.grid_x]}.map{|n| n.node_area_with_tree_path}
    end
  end

  def leaf_node_path
    if node_kind == 'ad'
      ad_type
    elsif children_count == 0
      tree_path
    end
  end

  def leaf_node_layout
    # keys are tags and values are article rect
    if node_kind == 'ad'
      [ad_type]
    elsif children_count == 0
      [grid_x,grid_y,column, row]
    else
      leaf_nodes.sort_by{|n| [n.grid_y, n.grid_x]}.map{|n| n.node_area}
    end
  end

  def story_count
    if node_kind == 'ad'
      0
    else
      leaf_nodes.count
    end
  end

  def save_pillar
    # save unique root node that is non-leaf_node  
    Pillar.where(column:column, row:row, layout:leaf_node_layout).first_or_create unless is_leaf?
    LayoutNode.where(column:column, row:row, layout:leaf_node_layout).first_or_create unless is_leaf?
  end

  def change_pillar(template)
    action_string == template.template
  end

  # creating pillar by running actions to the root node
  def self.make_pillar(column, row, actions)
    root = LayoutNode.where(column: column, row:row, actions:actions).first
    if root
      puts "found existing one !!!"
      return root
    else 
      root = LayoutNode.create(column: column, row:row, actions:actions)
      root.perform_actions
    end
  end

  def perform(action)
    case action
    when 'h', 'h*1'
      h_divide
    when 'h*2','h*3','h*4', 'h*5', 'h*6', 'h7','h*8', 'h9', 'h*10', 'h11', 'h12', 'h13','h14'
      h_divide_times(action)
    when 'v'
      v_divide
    when 'v*2','v*3','v*4','v*5', 'v*6',
      v_divide_times(action)
    when 'v+1','v+2','v+3'
      position = action.split("+")[1].to_i
      v_divide_at(position)
    when 'v-1','v-2', 'v-3'
      position = action.split("-")[1].to_i
      v_divide_at(position)
    else
      puts "Action:#{action} not supported !!!"
    end
  end

  # this is called right after LayoutNode is created
  def set_actions
    puts  "+++++++ actions:#{actions}"
    return if actions == []
    actions.each do |action_item|
      if action_item.class == String
        target = self
        action = action_item
      else
        target = root.find_node_with_tag(action_item[0])
        action = action_item[1]
      end
      if target.nil?
        puts "action_item:#{action_item}"
      end
      unless target
        puts "Failed actions:#{actions}"
        puts "Failed at #{action_item}!!!"
        break
      end

      result = target.perform(action)
      unless result
        puts "row#{row}!!!"
        puts "Failed with #{action_item}!!!"
        count                     = leaf_nodes.count
        # update(box_count: count, actions: actions, profile:new_profile)
        new_layout_with_pillar_path     = leaf_node_layout_with_pillar_path
        update(box_count: count, actions: actions,  layout_with_pillar_path:new_layout_with_pillar_path)
        break 
      end
    end
    count                         = leaf_nodes.count
    new_layout_with_pillar_path   = leaf_node_layout_with_pillar_path
    update(box_count: count, actions: actions,  layout_with_pillar_path:new_layout_with_pillar_path)
    puts "all actions succeeded!"
    return self
  end

  # this is called during working_article editing
  def add_action(action_item)
    if action_item.class == String
      target = self
      action = action_item
    else
      target = root.find_node_with_tag(action_item[0])
      action = action_item[1]
    end
    if target.nil?
      puts "action_item:#{action_item}"
    end
    unless target
      puts "Failed actions:#{actions}"
      puts "Failed at #{action_item}!!!"
      return
    end
    result = target.perform(action)
    unless result
      puts "row#{row}!!!"
      puts "Failed with #{action_item}!!!"
      return 
    end
    actions << action_item
    count                         = leaf_nodes.count
    new_layout_with_pillar_path   = leaf_node_layout_with_pillar_path
    update(box_count: count, actions: actions,  layout_with_pillar_path:new_layout_with_pillar_path)
  end

  def find_node_with_tag(tag)
    return self if tag.nil?
    level = tag.split("_")
    case level.length
    when 1
      first_level = level[0].to_i - 1
      children[first_level]
    when 2
      first_level = level[0].to_i - 1
      second_level = level[1].to_i - 1
      children[first_level].children[second_level]
    when 3
      first_level = level[0].to_i - 1
      second_level = level[1].to_i - 1
      third_level = level[1].to_i - 1
      children[first_level].children[second_level].children[third_level]
    else
      puts '4th level not supported'
      nil
    end
  end

  def rect
    [grid_x,grid_y, column,row]
  end

  # assume layout_item change only adds or subtracts, not vertical cut
  def update_layout_node(layout_item)
    new_box_count = 0
    if layout_item.length == 4 
      new_box_count = 1
    else
      new_box_count = layout_item[4]
    end
    difference = new_box_count - box_count
    if difference > 0
      if new_box_count > box_count
        # add more box
        difference.times do
          add_v_child
        end
      elsif difference < 0
        # remove more box
        -difference.times do
          remove_last_child
        end
      end
    end

  end

  private

  def init_layout_node
    self.grid_x = 0 unless grid_x
    self.grid_y = 0 unless grid_y
    self.actions = actions || []
    self.box_count = 1 
    self.layout_with_pillar_path = [[grid_x, grid_y, column, row, "1"]]
    self.node_kind = 'article' unless node_kind
    self.tag = tree_path
    self.profile = "#{column}x#{row}_#{box_count}"
    true
  end

end
