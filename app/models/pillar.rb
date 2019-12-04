# == Schema Information
#
# Table name: pillars
#
#  id                :bigint           not null, primary key
#  grid_x            :integer
#  grid_y            :integer
#  column            :integer
#  row               :integer
#  order             :integer
#  box_count         :integer
#  layout_with_pillar_path :text
#  layout            :text
#  profile           :string
#  finger_print      :string
#  region_id         :bigint
#  region_type       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# layout_with_pillar_path
# a Array of node array [x,y,width,height, ancestry] sorted by by order
class Pillar < ApplicationRecord
  belongs_to :region, :polymorphic => true
  has_many :working_articles
  before_create :init_pillar 
  after_create :create_articles 
  serialize :layout_with_pillar_path, Array
  serialize :layout, Array
  include RectUtils

  def story_count
    layout.length
  end

  def update_pdf_chain

  end

  def update_pdf_chain(working_article)
    upchain_folders = working_article.upchain_folders
    upchain_folders.each do |upchain|
      merge_children_pdf(upchain)
    end
    page.generate_pdf_with_time_stamp
  end

  def upchain_folders
    path_element = pillar_order.split("_")
    chain = []
    while path_element.pop do
      chain << path_element.join("/")
    end
    chain
  end

  # this is big deal!!!!!
  # convert layout_with_pillar_path to node tree
  # 1. 
  # given order list, return layout_node
  def generate_node
    order_collectoin = layout2tag.map{|r| r[4]}
    puts "order_collectoin:#{order_collectoin}"
    node = LayoutNode.create(column:column, row: row , order: order, grid_x:0, grid_y:0)
    if order_collectoin == []
      return node
    elsif order_collectoin == %w[1 2]
      return LayoutNode.make_pillar(column, row, ['h'])
    elsif order_collectoin == %w[1 2 3]
      return LayoutNode.make_pillar(column, row, ['h','h'])
    elsif order_collectoin == %w[1 2 3_1 3_2]
      return node.perform_actions(['h','h',['3','v']])

      return node.h_divide.h_divide.v_divide('3')
    elsif order_collectoin == %w[1 2 3_1 3_2_1 3_2_2]
      return node.h_divide.h_divide.v_divide('3').h_dived('3_2')
    else
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

  def path
    if region.class == Page
      region.path + "/#{order}"
    else
      "#{Rails.root}/public/pillar/#{column}/#{row}/#{box_count}/#{id}"
    end
  end

  # def pdf_image_path
  #   # if @time_stamp
  #   "/#{publication_id}/issue/#{date.to_s}/#{page_number}/#{latest_pdf_basename}"
  # end

  def publication_id
    region.publication_id
  end

  def date
    region.date.to_s
  end

  def page_number
    region.page_number
  end

  def url
    "/#{publication_id}/issue/#{date}/#{page_number}/#{order}"
  end


  def pdf_image_path
    url + "/story.pdf"
  end

  def jpg_image_path
    url + "/story.jpg"
  end

  def create_article_folder
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end

  def x
    grid_x*region.grid_width
  end

  def y
    grid_y*region.grid_height
  end

  def width
    column*region.grid_width
  end

  def height
    row*region.grid_height
  end

  def pillar_yaml
    h = {}
    h[:width]        = width
    h[:height]       = height
    h[:pillar_frame] = layout_with_pillar_path
    h.to_yaml
  end

  def config_yml_path
    path + "/pillar_config.yml"
  end

  def save_pillar_yaml
    system "mkdir -p #{path}" unless File.directory?(path)
    File.open(config_yml_path, 'w'){|f| f.write pillar_yaml}
  end

  def save_config_file
    system "mkdir -p #{path}" unless File.directory?(path)
    File.open(config_yml_path, 'w'){|f| f.write pillar_config.to_yaml}
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
    File.open(csv_path, 'w'){|f| f.write csv}
  end

  def h_scale
    10
  end

  def v_scale
    5
  end

  def choices
    LayoutNode.where(column:column, row:row).sort_by{|n| n.box_count}
  end

  def to_svg_with_jpg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{width} #{height}' >
      <rect fill='white' x='0' y='0' width='#{width}' height='#{height}' />
      #{box_svg_with_jpg}
    </svg>
    EOF
  end

  def box_svg_with_jpg
    # +++++ using pdf image for now
    box_element_svg = pillar_svg_with_pdf
    box_element_svg += "<g transform='translate(#{0},#{0})' >\n"
    working_articles.each do |article|
      box_element_svg += article.pillar_svg
    end
    box_element_svg += '</g>'
    box_element_svg
  end

  def pillar_svg_with_pdf
    "<image xlink:href='#{pdf_image_path}' x='0' y='0' width='#{width}' height='#{height}' />\n"
  end

  def to_svg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{column*h_scale} #{row*v_scale}' >
      <rect fill='yellow' x='0' y='0' width='#{column*h_scale}' height='#{row*v_scale}' />
      #{layout_svg}
    </svg>
    EOF
  end

  def layout_svg
    s = ""
    layout_array = layout
    layout_array.each do |rect|
      if rect.is_a?(Hash)
        s += box_svg(rect.values.first)
      else
        s += box_svg(rect)
      end
    end
    s
  end

  def box_svg(rect)
    "<rect class='rectfill' stroke='black' stroke-width='1' fill-opacity='0.0' x='#{(rect[0])*h_scale}' y='#{(rect[1])*v_scale}' width='#{rect[2]*h_scale}' height='#{rect[3]*v_scale}' />\n"
  end

  def upchain_folders
    path_element = order.split("_")
    chain = []
    while path_element.pop do
      chain << path_element.join("/")
    end
    chain
  end

  def pillar_union_rect(pillar_rects)
    union = pillar_rects.first
    pillar_rects.each_with_index do |rect, i|
      next if i == 0
      union = union_rect(union, rect)
    end
    union
  end

  def create_articles
    if region.class == Page
      save_pillar_yaml

      FileUtils.mkdir_p(path) unless File.exist?(path)
      if layout_with_pillar_path.first.class == Integer
        # this is case when layout_with_pillar_path is Array of 5 element
        h = {page:region, pillar:self, order: "#{order}_#{layout_with_pillar_path[4]}", grid_x:layout_with_pillar_path[0], grid_y:layout_with_pillar_path[1], column:layout_with_pillar_path[2], row: layout_with_pillar_path[3]}
        WorkingArticle.where(h).first_or_create
      else
        # this is case when layout_with_pillar_path is Array of Arrays
        layout_with_pillar_path.each do |box|
          h = {page:region, pillar:self, pillar_order: "#{order}_#{box[4]}", grid_x:box[0], grid_y:box[1], column:box[2], row: box[3]}
          WorkingArticle.where(h).first_or_create
        end
      end
    end
  end

  def change_layout(new_node_layout_with_pillar_path)
    if layout_with_pillar_path.length > new_node_layout_with_pillar_path.length
      # delete current pillar folders, if new pillar has less folders than current one
      Dir.glob("#{path}/**").each_with_index do |folder, i|
        next if i < new_node_layout_with_pillar_path.length
        system("rm -rf #{folder}")
      end
    end
    update(layout_with_pillar_path:new_node_layout_with_pillar_path)
    save_pillar_yaml
    # new_layout_with_pillar_path = new_node_layout_with_pillar_path.map{|box_info| "#{order}_#{box_info[4]}"}
    current_articles = working_articles.sort_by{|a| a.order}
    new_node_layout_with_pillar_path.each_with_index do |box_info, i|
      current_article = current_articles[i]
      new_rect  = [box_info[0], box_info[1], box_info[2], box_info[3]]
      new_size  = [box_info[2],box_info[3]]
      new_order = "#{order}_#{box_info[4]}"
      box_info[4] = new_order
      if current_article && box_info == current_article.rect_with_order
        puts "same size and position, no need to chnage anything"
      elsif current_article && new_order == current_article.order
        h = {}
        h[:grid_x] = box_info[0]
        h[:grid_y] = box_info[1]
        h[:column] = box_info[2]
        h[:row] = box_info[3]
        current_article.update(h)
        current_article.generate_pdf_with_time_stamp
      elsif current_article 
        puts "change current article order"
        current_article.change_article(box_info)
      else
        puts "create new one ..."
        h = {page:region, pillar:self, pillar_order: new_order, grid_x:box_info[0], grid_y:box_info[1], column:box_info[2], row: box_info[3]}
        w = WorkingArticle.where(h).first_or_create
        w.update_pdf_chain
      end
    end
    region.generate_pdf_with_time_stamp
  end

  def init_pillar
    profile = "#{column}x#{row}_#{box_count}"
    self.profile = profile
    if layout_with_pillar_path == []
      n = LayoutNode.where(profile: profile).first
      if n
        self.layout_with_pillar_path = n.layout_with_pillar_path
        self.finger_print = n.finger_print
      else
        
      end
    end

  end


end
