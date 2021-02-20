
module WorkingArticlePillarMethods
  extend ActiveSupport::Concern
  
  def touch_story_md
    system("touch #{story_path}")
  end

  def rect_with_order
    [grid_x, grid_y, column, row, pillar_order]
  end

  def rect
    [grid_x, grid_y, column, row]
  end

  def overlap_rect
    [grid_x, grid_y, column, row, extended_line_count]
  end

  def size
    [column, row]
  end

  def page_number
    page.page_number
  end

  def tree_path
    pillar_order.split("_").join("/")
  end

  def layout_node_order
    pillar_order.split("_")[1..-1].join("_")
  end

  def add_able?
    # it should have enough room
    false
  end

  def delete_able?
    # it should be pillar_bottom 
    # non single article
    pillar_order.count("_") >= 2
  end

  # only allow auto_adjustable to non-attached and overlap  
  # do not allow it to drop or divide
  def auto_adjustble?
    return true if attached_type.nil? || attached_type == 'overlap'
    false
  end

  def v_splitable?
    # it should not have horzontal 
    # node_level shoud be 1
    pillar_order.count("_") < 2 && column > 1 
  end

  def pillar_member?
    # true
    pillar_order && pillar_order.include?("_")
  end

  def bottom_member?
    bottom == pillar.row
  end

  def bottom
    grid_y + row
  end

  def adjustable_height?
    return false # unless bottom_member?
  end

  def images_directory_path
    "#{path}/images"
  end

  def make_images_directory
    FileUtils.mkdir_p(images_directory_path) unless File.exists?(images_directory_path)
  end
  
  def layout_path
    "#{path}/layout.rb"
  end

  def backup_path
    "#{Rails.root}/public/backup" + "/#{page_number}/#{pillar_order}"
  end

  def move_it
    # 1. move every file in the directory to backup_path
    FileUtils.mkdir_p(backup_path) unless File.exist?(backup_path)
    FileUtils.mv Dir.glob("#{path}/*"), backup_path
  end

  def restore
    FileUtils.mv Dir.glob("#{backup_path}/*"), path
    FileUtils.rm_rf(backup_path)
  end

  def clear_old_files
    # clear files in the directory
    system("cd #{path} && rm *") if File.exist?(path)
  end

  def create_article_folder
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end

  def change_article(box_info)
    current_info = []
    current_info[0] = grid_x
    current_info[1] = grid_y
    current_info[2] = column
    current_info[3] = row
    current_info[4] = pillar_order
    # check if page column has changed
    page_column_changed = false
    page_column_changed = true if grid_width.to_i != page.grid_width.to_i
    # return if pillar change is not effecting this article, save time 
    return if (box_info == current_info) && !page_column_changed

    clear_old_files
    self.grid_x             = box_info[0]
    self.grid_y             = box_info[1]
    self.column             = box_info[2]
    self.row                = box_info[3]
    self.pillar_order       = box_info[4]
    #TODO add article_kind, default = 기사, 기고, 박스기고, 사설, 만평, 사진, 부고/인사
    self.grid_width         = page.grid_width if page_column_changed
    self.is_front_page      = true if page.is_front_page?
    self.on_left_edge       = true if pillar.on_left_edge? && grid_x == 0
    self.on_right_edge      = true if pillar.on_right_edge? # && pillar.grid_x + column  == pillar.page.column
    self.extended_line_count = 0
    self.save
    create_article_folder
    save_article
    generate_pdf_with_time_stamp(no_page_pdf: true)
  end

  def svg_unit_width
    page.svg_unit_width
  end

  def svg_unit_height
    page.svg_unit_height
  end

  def box_svg(y_position)
    height = read_height
    binding.pry unless height
    if pillar_order.split("_").length <= 2
      text_font_size = 100
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y_position + height/2}' stroke-width='0' ><tspan font-size='#{text_font_size}' x='#{x + width/2 - text_font_size/2}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"
    else
      text_font_size = 50
      # TODO hanlde overlap, drop, divide
      case attached_type
      when "divide"
        y_position = parent.y
      when "drop"
        starting_article_order = pillar_order.split("_")[1].to_i
        y_position = pillar.root_articles[starting_article_order - 1].y
      when "overlap"
        y_position = parent.y + (parent.height - height)
      end
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y_position + height/2}' stroke-width='0' ><tspan font-size='#{text_font_size}' x='#{x + width/2 - text_font_size/2 }' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"

    end
    # TODO this is a hack to make it work need to find out why i need this
    # link box does not seen to get effected by the g transform ??
    page_margin = 42
    svg += "<a xlink:href='/working_articles/#{id}'><rect class='rectfill' stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x - page_margin}' y='#{y_position - page_margin}' width='#{width}' height='#{height}' /></a>\n"
  end

  def max_height_in_lines
    pillar.max_height_in_lines(self)
  end

  def min_height_in_lines
    14
  end

  def drop_height_in_lines
    pillar.height_in_lines - y_in_lines
  end

  def order_from_pillar_order
    pillar_order.split("_")[1].to_i - 1
  end

  def default_height_in_lines
    return parent.default_height_in_lines  if attached_type == '나눔'
    return parent.drop_height_in_lines  if attached_type == '내림'
    return 7  if attached_type == '쪽기사'
    lines, remainder = pillar.default_height_in_lines
    if remainder == 0
      lines
    elsif order_from_pillar_order + 1 <= remainder
      lines + 1
    else
      lines
    end
  end

end

