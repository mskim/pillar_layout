# frozen_string_literal: true

# == Schema Information
#
# Table name: pillars
#
#  id               :bigint           not null, primary key
#  box_count        :integer
#  column           :integer
#  direction        :string
#  grid_x           :integer
#  grid_y           :integer
#  has_drop_article :boolean
#  order            :integer
#  page_ref_type    :string
#  profile          :string
#  row              :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  page_ref_id      :bigint
#
# Indexes
#
#  index_pillars_on_page_ref_id  (page_ref_id)
#

class Pillar < ApplicationRecord
  belongs_to :page_ref, polymorphic: true
  # has_many :working_articles,  :dependent => :delete_all #:dependent=> :destroy,
  has_many :working_articles, -> { order(pillar_order: :asc) }, dependent: :delete_all

  has_one :layout_node
  before_create :init_pillar
  after_create :create_layout
  include RectUtils


  def max_pushed_line_count
    (row - working_articles.length)*7
  end

  def bottom_article
    working_articles.last
  end

  def available_bottom_space
    if working_articles.length > 1
      room = (working_articles.last.row - 1)*7
      extened_line_sum - room
    else
      0
    end
  end

  def add_article

    # check if it is addable?
    self.box_count    +=  1
    self.save
    layout_node.add_v_child
    layout_node.update_layout_with_pillar_path
    new_layout = layout_node.layout_with_pillar_path.dup
    working_articles.each_with_index do |w, i|
      box_rect      = new_layout[i].dup
      box_rect[4]   = w.pillar_order
      w.change_article(box_rect)
    end
    working_articles_count = working_articles.length
    box_rect = new_layout.last
    h = { page_id: page_ref.id, pillar: self, pillar_order: "#{order}_#{working_articles_count + 1}", grid_x: box_rect[0], grid_y: box_rect[1], column: box_rect[2], row: box_rect[3] }
    w = WorkingArticle.where(h).first_or_create
    page_ref.generate_pdf_with_time_stamp
  end
  
  def remove_article(article)
    self.box_count    -=  1
    self.save
    # layout_node.remove_last_child
    layout_node_order = article.layout_node_order
    article.delete_folder
    article.destroy
    layout_node.remove_child(layout_node_order)
    layout_node.update_layout_with_pillar_path
    new_layout = layout_node.layout_with_pillar_path.dup
    working_articles.reload
    working_articles.each_with_index do |w, i|
      box_rect      = new_layout[i].dup
      box_rect[4]   = w.pillar_order.split("_")[0..-2].join("_")
      w.change_article(box_rect)
    end
    page_ref.generate_pdf_with_time_stamp
  end

  def pillar_siblings_of(article)
    article_pillar_order_depth = article.pillar_order.split("_").length
    article_siblings = working_articles.select{|w| w.pillar_order.split("_").length == article_pillar_order_depth}.sort_by{|a| a.pillar_order}
  end

  def following_pillar_siblings_of(article)
    working_articles.select{|a| a.pillar_order > article.pillar_order}
  end

  # retrun bottom siblling of given article
  def bottom_article_of_sibllings(article)
    article_siblings = pillar_siblings_of(article)
    article_siblings.last
  end

  def max_grid_x
    grid_x + column
  end

  def max_grid_y
    grid_y + row
  end

  # check if given article is  bottom of sibllings
  def bottom_article_of_sibllings?(article)
    article == bottom_article_of_sibllings(article)
  end

  def extened_line_sum
    working_articles.reload
    root_articles = working_articles.select{|w| !w.parent && w.attached_type.nil?}
    root_articles.map{|w| w.extended_line_count}.reduce(:+)
    #TODO
    # working_articles.select{|w| !w.parent && w.attached_type.nil?}.sum{:extended_line_count}
  end

  def extened_line_sum_for_previous_root_articles(bordering_y)
    working_articles.reload
    sum = 0
    root_articles = working_articles.select{|w| !w.parent && w.attached_type.nil?}
    amount =root_articles.select{|w| w.grid_y < bordering_y}.map{|w| w.extended_line_count}.reduce(:+)
    sum += amount if amount
    # working_articles.select{|w| w.grid_y < bordering_y}.sum{:extended_line_count}
  end

  # update pillar_config file and working_article grid_y and row after cut
  def update_working_article_cut(cut_action)
    layout_node.add_action(cut_action)
    new_layouts = layout_with_pillar_path
    sorted_working_articles = working_articles
    new_layouts.each_with_index do |new_layout, i|
      sorted_working_articles[i].update(grid_x: new_layout[0], grid_y:new_layout[1], column:new_layout[2], row:new_layout[3])
    end
  end

  def story_count
    box_count
  end

  def path
    if page_ref.class == Page
      page_ref.path + "/#{order}"
    else
      "#{Rails.root}/public/pillar/#{column}/#{row}/#{box_count}/#{id}"
    end
  end

  def publication_id
    page_ref.publication_id
  end

  def date
    page_ref.date.to_s
  end

  def page_number
    page_ref.page_number
  end

  def url
    "/#{publication_id}/issue/#{date}/#{page_number}/#{order}"
  end

  def pdf_image_path
    url + '/story.pdf'
  end

  def jpg_image_path
    url + '/story.jpg'
  end

  def create_article_folder
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end

  def top_position?
    return true if grid_y == 0 
    return true if grid_y == 1 && page_ref.page_number == 1
    false
  end

  def on_left_edge?
    return true if grid_x == 0 
  end

  def on_right_edge?
    return true if grid_x + column == page_ref.column
  end

  def heading_space
      page_ref.heading_space
  end

  def flipped_origin
    [page_ref.left_margin + grid_x*page_ref.grid_width, page_ref.height - height - y]
  end

  def x
    grid_x * page_ref.grid_width  + page_ref.left_margin
  end

  # y should not take page_heading margin, since this will be taken care of by working_article
  def y
    grid_y * page_ref.grid_height + page_ref.top_margin
  end

  # svg_y should take page_heading margin into consideration
  def svg_y
    grid_y * page_ref.grid_height + page_ref.heading_space + page_ref.top_margin
  end

  def width
    column * page_ref.grid_width
  end

  def height
    if page_ref.page_number == 1 && grid_y == 1
      row * page_ref.grid_height - heading_space
    elsif grid_y == 0
      row * page_ref.grid_height - heading_space
    else
      row * page_ref.grid_height - heading_space
    end
  end

  def page_width
    page_ref.width
  end

  def page_height
    page_ref.height
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      header = %w[column row count layout]
      csv << header
      all.each do |item|
        csv << item.attributes.values_at(*header)
      end
    end
  end

  def self.save_csv
    csv = Pillar.to_csv
    csv_path = "#{Rails.root}/public/pillar.csv"
    File.open(csv_path, 'w') { |f| f.write csv }
  end

  def h_scale
    10
  end

  def v_scale
    5
  end

  def choices
    # ad svg
    nodes = LayoutNode.where(column: column, row: row).sort_by(&:box_count)
    nodes.map { |n| [n, n.page_embeded_svg(page_ref.column, grid_x, grid_y)] }
  end

  def rect
    [grid_x, grid_y, column, row]
  end

  def to_svg_with_jpg
    svg = <<~EOF
      <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{page_width} #{page_height}' >
        <rect fill='gray' x='0' y='0' width='#{page_width}' height='#{page_height}' />
        <rect fill='white' x='#{x}' y='#{y}' width='#{width}' height='#{height}' />
        #{box_svg_with_jpg}
      </svg>
    EOF
  end

  def box_svg_with_jpg
    # +++++ using pdf image for now
    # box_element_svg = pillar_svg_with_pdf
    box_element_svg = "<g transform='translate(#{x},#{y})' >\n"
    working_articles.each do |article|
      box_element_svg += article.box_svg
    end
    box_element_svg += '</g>'
    box_element_svg
  end

  def pillar_svg_with_pdf
    "<image xlink:href='#{pdf_image_path}' x='#{x}' y='#{y}' width='#{width}' height='#{height}' />\n"
  end

  def to_svg
    svg = <<~EOF
      <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{column * h_scale} #{row * v_scale}' >
        <rect fill='yellow' x='0' y='0' width='#{column * h_scale}' height='#{row * v_scale}' />
        #{layout_svg}
      </svg>
    EOF
  end

  def layout_svg
    "<rect fill='yellow' stroke='black' stroke-width='1' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' />\n"
  end

  def box_svg(rect)
    "<rect fill='yellow' stroke='black' stroke-width='1' fill-opacity='0.0' x='#{(rect[0]) * h_scale}' y='#{(rect[1]) * v_scale}' width='#{rect[2] * h_scale}' height='#{rect[3] * v_scale}' />\n"
  end

  def pillar_union_rect(pillar_rects)
    union = pillar_rects.first
    pillar_rects.each_with_index do |rect, i|
      next if i == 0
      union = union_rect(union, rect)
    end
    union
  end

  def change_pillar_layout(new_pillar)
    current_box_count = box_count
    new_box_count     = new_pillar.box_count
    new_layout        =  new_pillar.layout_with_pillar_path.dup
    new_box_count     =  new_layout.length
    self.grid_x       =  new_pillar.grid_x
    self.grid_y       =  new_pillar.grid_y
    self.column       =  new_pillar.column
    self.row          =  new_pillar.row
    self.box_count    =  new_pillar.box_count
    self.order        =  new_pillar.order
    self.save
    removing_articles = current_box_count - new_box_count
    if removing_articles == 0
      # current and new pillar size are equal
      working_articles.each_with_index do |w, i|
        box_rect     = new_layout[i]
        pillar_order = "#{order}_#{i+1}"
        box_rect[4]  = pillar_order
        w.change_article(box_rect)
      end
    elsif removing_articles > 0 # current box is greater than new_layout
      ordered_working_articles  = working_articles
      new_layout.each_with_index do |box_rect, i|
        pillar_order = "#{order}_#{i+1}"
        box_rect[4]  = pillar_order
        ordered_working_articles[i].change_article(box_rect)
      end
      # delete working_articles from pillar
      removing_articles.times do
        w = working_articles.last
        if w
          system("rm -rf #{w.path}")
          w.destroy
          working_articles.reload
        end
      end
    elsif removing_articles < 0 # removing_articles < 0 add articles
      # update remaininng working_articles current sizes are less than the new_pillar, create some 
      working_articles.each_with_index do |w, i|
        box_rect = new_layout[i].dup
        pillar_order = "#{order}_#{i+1}"
        box_rect[4]  = pillar_order
        w.change_article(box_rect)
      end
      working_articles_count = working_articles.length
      # add working_articles to pillar
      (-removing_articles).times do |i|
        box_rect = new_layout[working_articles_count + i]
        h = { page_id: page_ref.id, pillar: self, pillar_order: "#{order}_#{working_articles_count + i + 1}", grid_x: box_rect[0], grid_y: box_rect[1], column: box_rect[2], row: box_rect[3] }
        w = WorkingArticle.where(h).first_or_create
      end
    end
  end

  def height_in_lines
    if page_ref
      page_ref.height_in_lines
    else
      7
    end
  end

  def create_layout
    create_layout_node
    create_articles if page_ref.class == Page
  end
  
  def create_layout_node
    # box_count = 1 if box_count.nil? || box_count < 1
    if box_count > 1
      actions = ["h*#{box_count - 1}"]
    end
    LayoutNode.where(pillar: self, column: column, row: row, box_count:box_count, actions: actions).first_or_create
    layout_node.set_actions
  end

  # this is called from page_layout, when page_layout has changed
  def update_pillar(new_layout)
    current_rect      = [grid_x, grid_y, column, row]
    if  current_rect != new_layout[0..3]
      self.grid_x = new_layout[0]
      self.grid_y = new_layout[1]
      self.grid_x = new_layout[2]
      self.grid_x = new_layout[3]
      self.save
    end
    layout_node.update_layout_node(new_layout)
  end

  def layout_with_pillar_path
    layout_node.layout_with_pillar_path
  end

  def create_articles
    FileUtils.mkdir_p(path) unless File.exist?(path)
    if box_count == 1
      h = { page_id: page_ref.id, pillar: self, pillar_order: "#{order}", order: 1, grid_x: 0, grid_y: 0, column: column, row: row }
      WorkingArticle.where(h).first_or_create
    # elsif layout_with_pillar_path.first.class == Integer
    #   # this is case when layout_with_pillar_path is Array of 5 element
    #   h = { page: page_ref, pillar: self, order: "#{order}_#{layout_with_pillar_path[4]}", grid_x: layout_with_pillar_path[0], grid_y: layout_with_pillar_path[1], column: layout_with_pillar_path[2], row: layout_with_pillar_path[3] }
    #   WorkingArticle.where(h).first_or_create
    else
      layout_with_pillar_path.each_with_index do |box|
        h = { page_id: page_ref.id, pillar: self, pillar_order: "#{order}_#{box[4]}", grid_x: box[0], grid_y: box[1], column: box[2], row: box[3] }
        WorkingArticle.where(h).first_or_create
      end
    end
  end

  def init_pillar
    self.profile = "#{page_ref.column}_#{column}_#{row}_#{box_count}"
  end

  def delete_folder
    system("rm -rf #{path}")
  end

  def copy_from_sample
    source_folder = "#{Rails.root}/public/1/pillar_sample/#{profile}"
    FileUtils.cp(source_folder, path)
  end

  def save_to_sample
    return unless page_ref.class == Page
    target_folder = "#{Rails.root}/public/1/pillar_sample/#{profile}"
    unless File.exist?(source_folder) 
      FileUtils.cp(path, target_folder)
    end
  end

  def article_info
    working_articles.map{|w| w.rect_with_order}
  end

  def node_info
    layout_node.leaf_nodes.map{|n| n.rect_with_tag}
  end

  # +++++++++++ drop article ++++++++++++++++++++
  # create aritcle on the right side which spans from top of current article to the bottom on pillar
  # if current article is not the top article, lock all article above the currnt one.
  
  def has_drop_article?
    # has_drop_article == true
    working_articles.each do |w|
      return true if w.attached_type == 'drop'
    end
    false
  end
  
  def add_default_drop(starting_article_order = 1)
    default_column = 1
    default_column = 2 if column > 4
    add_right_drop(default_column, starting_article_order)
  end


  # create aritcle on the left side which spans from top of current article to the bottom on pillar
  # if current article is not the top article, lock all article above the currnt one.
  def add_right_drop(column_width_in_grid, starting_article_order=1)
    return if column_width_in_grid >= column - 1
    return if has_drop_article?
    # update(has_drop_article: true)
    # update all existing articles column
    new_column = column - column_width_in_grid
    working_articles.each_with_index do |w, i|
      next if i < starting_article_order - 1
      w.update(column:new_column)
      w.generate_pdf_with_time_stamp
    end
    h           = {}
    h[:attached_type] = "drop"
    h[:attached_position] = "우"
    h[:grid_x]  = column - column_width_in_grid
    h[:grid_y]  = working_articles[starting_article_order - 1].grid_y
    h[:column]  = column_width_in_grid
    h[:row]     = row - h[:grid_y]
    h[:pillar]  = self
    h[:page_id] = page_ref.id
    h[:pillar_order]    = "#{order}_D"
    w = WorkingArticle.create(h)
    w.generate_pdf_with_time_stamp
    page_ref.generate_pdf_with_time_stamp
  end

  # create aritcle on the left side which spans from top of current article to the bottom on pillar
  # if current article is not the top article, lock all article above the currnt one.
  def add_left_drop(column_width_in_grid, starting_article_order=1)
    return if column_width_in_grid >= column - 1
    return if has_drop_article?
    update(has_drop_article: true)
    new_column = column - column_width_in_grid
    # update all existing articles grid_x and column
    working_articles.each_with_index do |w, i|
      next if i < starting_article_order - 1
      w.update(grid_x:column_width_in_grid, column:new_column)
      w.generate_pdf_with_time_stamp
    end
    h           = {}
    h[:attached_type] = "drop"
    h[:attached_position] = "좌"
    h[:grid_x]  = 0
    h[:grid_y]  = working_articles[starting_row_index].grid_y
    h[:column]  = column_width_in_grid
    h[:row]     = row - h[:grid_y]
    h[:pillar]  = self
    h[:page_id] = page_ref.id
    h[:pillar_order]    = "#{order}_L"
    w = WorkingArticle.create(h)
    w.generate_pdf_with_time_stamp
    page_ref.generate_pdf_with_time_stamp
  end

  # get articles that are affected following drop_starting_article
  def drop_affected_articles(drop_starting_article)
    working_articles.select do |w| 
      w.grid_y >= drop_starting_article.grid_y && w.attached_type !~ /^drop/
    end
  end

  def change_drop_value(drop_article, old_side, old_column)
    drop_column_changed = false
    new_article_column = column - drop_article.column
    drop_column = drop_article.column
    # position has changed
    drop_side = '우'
    if drop_article.attached_position == '좌'
      drop_side = '좌'
      drop_article.update(grid_x:0)
    else
      drop_side = '우'
      drop_article.update(grid_x:new_article_column)
    end

    # update drop_childen if drop_article.has_children?
    drop_article.change_drop_childen if drop_article.has_children?
    drop_affected_articles(drop_article).each do |affected_article|
      affected_article.adjust_room_for_drop(drop_side, drop_column)
    end
  end

  # remove drop and its children
  def remove_drop
    return unless has_drop_article?
    update(has_drop_article: false)
    working_articles.each do |w|
      if w.attached_type == 'drop'
        w.delete_drop_childen if w.has_children?
        w.delete_folder
        w.destroy
      elsif w.column != column
        w.update(grid_x:0, column:column)
        w.generate_pdf_with_time_stamp
      end
    end
    page_ref.generate_pdf_with_time_stamp
  end

end
