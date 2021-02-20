# frozen_string_literal: true

# == Schema Information
#
# Table name: pillars
#
#  id                      :bigint           not null, primary key
#  box_count               :integer
#  column                  :integer
#  direction               :string
#  grid_x                  :integer
#  grid_y                  :integer
#  has_drop_article        :boolean
#  layout_with_pillar_path :text
#  order                   :integer
#  profile                 :string
#  row                     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  page_id                 :bigint
#
# Indexes
#
#  index_pillars_on_page_id  (page_id)
#

class Pillar < ApplicationRecord
  belongs_to :page
  # has_many :working_articles,  :dependent => :delete_all #:dependent=> :destroy,
  has_many :working_articles, -> { order(pillar_order: :asc) }, dependent: :delete_all

  # has_one :layout_node
  before_create :init_pillar
  after_create :create_layout
  include RectUtils
  include GithubPillar
  serialize :layout_with_pillar_path, Array

  def save_as_page_layout
    a = [grid_x, grid_y, column, row, root_articles.length]
    article_atts = []
    h = {}
    working_articles.each_with_index do |w, i|
      # use 1 based, not 0 based for easy of use
      atts = w.save_as_page_layout(i + 1)
      article_atts << atts if atts != {}
    end
    # select non-nil only
    article_atts = article_atts.select{|e| !e.nil?}
    a << article_atts if article_atts != []
    a
  end

  def max_pushed_line_count
    (row - working_articles.length)*7
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

    update_layout_with_pillar_path
    working_articles.each_with_index do |w, i|
      if new_layout[i]
        box_rect      = new_layout[i]
        box_rect[4]   = w.pillar_order
        w.change_article(box_rect)
      end
    end
    working_articles_count = working_articles.length
    box_rect = new_layout.last
    h = { page: page, pillar: self, pillar_order: "#{order}_#{working_articles_count + 1}", grid_x: box_rect[0], grid_y: box_rect[1], column: box_rect[2], row: box_rect[3] }
    w = WorkingArticle.where(h).first_or_create
    set_article_defaults
    page.generate_pdf_with_time_stamp(relayout:true)
  end
  
  def remove_article(article)
    self.box_count    -=  1
    self.save
    update_layout_with_pillar_path
    working_articles.reload
    working_articles.each_with_index do |w, i|
      if new_layout[i]
        box_rect      = new_layout[i]
        p_order     = box_rect[4]
        new_order   = "#{order}_#{p_order}"
        box_rect[4] = new_order
        w.change_article(box_rect)
      end
    end
    set_article_defaults
    page.generate_pdf_with_time_stamp
  end

  def pillar_siblings_of(article)
    article_pillar_order_depth = article.pillar_order.split("_").length
    article_siblings = working_articles.select{|w| w.pillar_order.split("_").length == article_pillar_order_depth}.sort_by{|a| a.pillar_order}
  end

  def bottom_article
    w = working_articles.sort_by{|w| w.pillar_order}.last
    # w = working_articles.last
    return w.parent if w.parent
    w
  end

  def max_grid_x
    grid_x + column
  end

  def max_grid_y
    grid_y + row
  end

  def extened_line_sum
    working_articles.reload
    articles = sorted_root_working_articles
    articles.map{|w| w.extended_line_count}.reduce(:+)
  end

  def story_count
    box_count
  end

  def path
    if page.class == Page
      page.path + "/#{order}"
    else
      "#{Rails.root}/public/pillar/#{column}/#{row}/#{box_count}/#{id}"
    end
  end

  def publication_id
    page.publication_id
  end

  def date
    page.date.to_s
  end

  def page_number
    page.page_number
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
    return true if grid_y == 1 && page.page_number == 1
    false
  end

  def on_left_edge?
    return true if grid_x == 0 
  end

  def on_right_edge?
    return true if grid_x + column == page.column
  end

  def heading_space
      page.heading_space
  end

  def flipped_origin
    [page.left_margin + grid_x*page.grid_width, page.height - height - y]
  end

  def x
    grid_x * page.grid_width  + page.left_margin
  end

  # y should not take page_heading margin, since this will be taken care of by working_article
  def y
    grid_y * page.grid_height + page.top_margin
  end

  def y_in_lines
    if top_position?
      grid_y*7 + page.page_heading_margin_in_lines
    else
      grid_y*7 
    end
  end

  def front_page?
    page.page_number == 1
  end

  def height_in_lines
    if front_page? && top_position?
      (row)*7 - 3
    elsif top_position?
      row*7 - y_in_lines
    else
      row*7
    end
  end
  # svg_y should take page_heading margin into consideration
  def svg_y
    grid_y * page.grid_height + page.heading_space + page.top_margin
  end

  def width
    column * page.grid_width
  end

  def height
    if page.page_number == 1 && grid_y == 1
      row * page.grid_height - heading_space
    elsif grid_y == 0
      row * page.grid_height - heading_space
    else
      row * page.grid_height - heading_space
    end
  end

  def page_width
    page.width
  end

  def page_height
    page.height
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
    nodes.map { |n| [n, n.page_embeded_svg(page.column, grid_x, grid_y)] }
  end

  def rect
    [grid_x, grid_y, column, row]
  end
  
  def page_heading_height
    page.heading_space
  end

  def box_svg_with_jpg
    box_element_svg = "<g transform='translate(#{x},#{y})' >\n"
    y_pos = 0
    # y_pos = page_heading_height if top_position?
    working_articles.each do |article|
      box_element_svg += article.box_svg(y_pos)
      # y_pos += article.height if article.attached_type.nil?
      y_pos += article.read_height if article.attached_type.nil?
    end
    box_element_svg += '</g>'
    box_element_svg
  end

  def box_svg_html_with_jpg
    box_element_svg = "<g transform='translate(#{x},#{y})' >\n"
    working_articles.each do |article|
      box_element_svg += article.box_svg_html
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
    new_box_count     = new_pillar[:box_count]
    self.grid_x       = new_pillar[:grid_x]
    self.grid_y       = new_pillar[:grid_y]
    self.column       = new_pillar[:column]
    self.row          = new_pillar[:row]
    self.box_count    = new_box_count
    self.order        = new_pillar[:order]
    self.save
    update_layout_with_pillar_path    
    removing_articles = current_box_count - new_box_count
    if removing_articles == 0
      # current and new pillar size are equal
      root_articles.each_with_index do |w, i|
        if new_pillar[i]
          box_rect    = layout_with_pillar_path[i]
          p_order     = box_rect[4]
          new_order   = "#{order}_#{p_order}"
          box_rect[4] = new_order
          w.change_article(box_rect)
        end
      end
    elsif removing_articles > 0 # current box is greater than new_layout
      ordered_working_articles  = root_articles
      layout_with_pillar_path.each_with_index do |box_rect, i|
        ordered_working_articles[i].change_article(box_rect)
      end
      # delete working_articles from pillar
      removing_articles.times do
        w = root_articles.last
        if w
          system("rm -rf #{w.path}")
          w.destroy
          # root_articles.reload
        end
      end
    elsif removing_articles < 0 # removing_articles < 0 add articles
      # update remaininng working_articles current sizes are less than the new_pillar, create some 
      root_articles.each_with_index do |w, i|
        if layout_with_pillar_path[i]
          box_rect    = layout_with_pillar_path[i]
          p_order     = box_rect[4]
          new_order   = "#{order}_#{p_order}"
          box_rect[4] = new_order
          w.change_article(box_rect)
        end
      end
      working_articles_count = root_articles.length
      # add working_articles to pillar
      (-removing_articles).times do |i|
        box_rect = layout_with_pillar_path[working_articles_count + i]
        if box_rect
          h = { page: page, pillar: self, pillar_order: box_rect[4], grid_x: box_rect[0], grid_y: box_rect[1], column: box_rect[2], row: box_rect[3] }
          w = WorkingArticle.where(h).first_or_create
        end
      end
    end
  end

  def create_layout
    update_layout_with_pillar_path
    create_articles # if page.class == Page
  end
  # 
  # first: [[0, 0, 5, 5, "1"], [0, 5, 5, 4, "2"]]
  # second: [[0, 0, 2, 3, "1"], [0, 3, 2, 3, "2"], [0, 6, 2, 3, "3"]]
  def update_layout_with_pillar_path
    layout_with_pillar_path = []
    box_height = row/story_count
    remainer = row % story_count
    story_count.times do |i|
      box = []
      box[0] = 0
      box[1] = grid_y
      box[2] = column
      box[3] = box_height
      box[3] += 1 if i < remainer # add remaining height at the top
      box[4] = "#{i+1}"
      layout_with_pillar_path << box
    end
    update(layout_with_pillar_path: layout_with_pillar_path)
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
    # TODO do not use layout_node
    layout_node.update_layout_node(new_layout)
  end

  def create_articles
    FileUtils.mkdir_p(path) unless File.exist?(path)
    layout_with_pillar_path.each_with_index do |box|
      box_count = box[4]
      box_count = 1 if box[4] == ""
      h = { page: page, pillar: self, pillar_order: "#{order}_#{box_count}", grid_x: box[0], grid_y: box[1], column: box[2], row: box[3] }
      WorkingArticle.where(h).first_or_create
    end
    set_article_defaults
    # end
  end

  def init_pillar
    self.profile = "#{page.column}_#{column}_#{row}_#{box_count}"
  end

  def delete_folder
    system("rm -rf #{path}")
  end

  def copy_from_sample
    source_folder = "#{Rails.root}/public/1/pillar_sample/#{profile}"
    FileUtils.cp(source_folder, path)
  end

  def save_to_sample
    return unless page.class == Page
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
    h                     = {}
    h[:attached_type]     = "drop"
    h[:attached_position] = "우"
    h[:grid_x]            = column - column_width_in_grid
    h[:grid_y]            = root_articles[starting_article_order - 1].grid_y
    h[:column]            = column_width_in_grid
    h[:row]               = row - h[:grid_y]
    h[:pillar]            = self
    h[:page]              = page
    h[:pillar_order]      = "#{order}_#{starting_article_order}_D"
    w = WorkingArticle.create(h)
    w.generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
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
    h[:page]    = page
    h[:pillar_order]    = "#{order}_L"
    w = WorkingArticle.create(h)
    w.generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
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

  def delete_working_articles
    working_articles.all.each do |w|
        w.delete_folder
        w.delete_attached_floats
        w.destroy
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
    page.generate_pdf_with_time_stamp
  end
  
  def article_map
    working_articles.sort_by{|w| w.pillar_order}.map do |w|
      w.layout_map
    end
  end

  def layout_map
    h = {}
    h[:order]             = order
    h[:pillar_rect]       = [x,y,width,height]
    h[:pillar_grid_rect]  = [grid_x, grid_y, column, row]
    h[:article_map]       = article_map
    h
  end

  def revert_all_extended_lines(options={})
    working_articles.each do |w|
      next if w.extended_line_count == 0
      w.update(extended_line_count: 0)
      w.generate_pdf_with_time_stamp
    end
    page.generate_pdf_with_time_stamp
  end

  def following_root_articles(article)
    article_index = root_articles.index(article)
    root_articles[article_index..-1]
  end

  # auto_adjust_height starting from given article
  def auto_adjust_height_starting_from(article)
    following_article = following_root_articles(article)
    update_y_in_lines
    following_article.each do |w|
      w.generate_pdf_with_time_stamp(adjustable_height: true)
    end
    adjust_articles_to_fit_pillar
  end

  def stamp_time
    t = Time.now
    h = t.hour
    @time_stamp = "#{t.day.to_s.rjust(2, '0')}#{t.hour.to_s.rjust(2, '0')}#{t.min.to_s.rjust(2, '0')}#{t.sec.to_s.rjust(2, '0')}"
  end

  def touch_articles
    working_articles.all.each do |w|
      w.touch_story_md
    end
  end

  # auto adjust height of all ariticles in pillar and relayout bottom article
  # set height_in_lines, extended_line_count

  def auto_adjust_height_all(options={})
    pillar_path               = path
    stamp_time
    result = RLayout::NewsPillar.new(pillar_path: pillar_path, time_stamp: @time_stamp)
    update_working_article_heights
    true
  end

  def update_working_article_heights
    root_articles.each_with_index do |root_article, i|
      root_article.update_height_in_lines
    end
  end

  # steps
  # 1. generate all root articles with full height
  # 2. call adjust_articles_to_fit_pillar
  # def auto_adjust_height_all
  #   update_y_in_lines
  #   root_articles.each do |w|
  #     w.generate_pdf_with_time_stamp(adjustable_height: true)
  #   end
  #   adjust_articles_to_fit_pillar
  # end


  # adjust_articles_to_fit_pillar
  # adjust heights from bottom until it fits
  def adjust_articles_to_fit_pillar
    differnce   = height_in_lines_sum - height_in_lines
    if differnce != 0
      # get adjusted_heights_array to fit
      new_heights_array    = adjusted_heights_array
      # puts new_heights_array.reduce(:+)
      root_articles.each_with_index do |article, i|
        new_height = new_heights_array[i]
        if article.read_height_in_lines != new_height
          article.generate_pdf_with_time_stamp(fixed_height_in_lines: new_height)
        end
      end
    end
  end

  def adjusted_heights_array
    current_heights = height_in_lines_array
    adjusted_heights = current_heights.dup
    diffenence      = current_heights.reduce(:+) - height_in_lines
    if diffenence > 0
      reminaing_overflow = diffenence
      current_heights.reverse.each_with_index do |article_height, i|
        if reminaing_overflow == 0 
          break
        elsif article_height > 14
          room = article_height - 14
          if room >= reminaing_overflow
            room = reminaing_overflow
            adjusted_heights[-(i+1)] = article_height - room
            break
          end
          reminaing_overflow -= room
          adjusted_heights[-(i+1)] = article_height - room
        end
      end
    else
      underflow = diffenence
      # grow bottom article by difference
      adjusted_heights[-1] += underflow
    end
    adjusted_heights
  end
  
  # read from disk
  def height_in_lines_array
    root_articles.map{|w| w.read_height_in_lines}
  end

  def height_in_lines_sum
    height_in_lines_array.reduce(:+)
  end

  def update_y_in_lines
    current_y = 0
    root_articles.each do |w|
      current_height_in_lines = w.read_height_in_lines
      w.update(y_in_lines: current_y)
      current_y += current_height_in_lines
    end
  end

  def y_in_lines_array
    root_articles.map{|w| w.y_in_lines}
  end

  def root_article_ids
    root_articles.map{|w| w.id}
  end

  def root_articles
    working_articles.select{|w| w.parent == nil}
  end

  def root_articles_count
    root_articles.length
  end

  def bottom_root_article
    w = root_articles.sort_by{|w| w.pillar_order}.last
  end
  
  # only the sorted top level roots
  def sorted_root_working_articles
    root_articles.sort_by{|w| w.pillar_order}
  end

  # sorted all level article, including divide, drop, and overlaps
  def sorted_all_working_articles
    working_articles.sort_by{|w| w.pillar_order}
  end

  def root_articles_height_sum_for_bottom
    article_height_in_lines_sum = 0
    root_articles = sorted_root_working_articles
    bottom_article = root_articles.last
    root_articles.each do |w|
      next if w == bottom_article
      article_height_in_lines_sum += w.height_in_lines
    end
    puts "article_height_in_lines_sum:#{article_height_in_lines_sum}"
    article_height_in_lines_sum
  end

  def bottom_article_room_in_lines
    height_in_lines - root_articles_height_sum_for_bottom
  end

  def prev_article(article)
    sorted = sorted_all_working_articles
    return article if sorted.first == article
    prev = sorted.first
    sorted.each do |sorted_article|
      return prev if sorted_article == article
    end
  end

  def next_article(article)
    sorted = sorted_all_working_articles
    return article if sorted.last == article
    sorted.each_with_index do |sorted_article, i|
      return sorted[i + 1] if sorted_article == article
    end
  end

  def root_articles_count
    root_articles.length
  end

  def default_height_in_lines
    count = root_articles_count
    h_in_lines = height_in_lines/count
    remainder = height_in_lines % count
    return h_in_lines, remainder
  end

  def default_article_heights
    root_articles.map{|w| w.default_height_in_lines}
  end

  # set default y_in_lines, height_in_lines
  def set_article_defaults
    default_heights = default_article_heights
    currnet_y_in_lines = 0
    root_articles.each_with_index do |w, i|
      current_height = default_heights[i]
      w.update(y_in_lines:currnet_y_in_lines, extended_line_count: 0)
      currnet_y_in_lines += current_height
    end
  end

end
