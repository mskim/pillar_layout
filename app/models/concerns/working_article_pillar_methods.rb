
module WorkingArticlePillarMethods
  extend ActiveSupport::Concern
  
  def rect_with_order
    [grid_x, grid_y, column, row, pillar_order]
  end

  def rect
    [grid_x, grid_y, column, row]
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
    self.grid_width         = page.grid_width if page_column_changed
    self.is_front_page      = true if pillar.page_ref.is_front_page?
    self.on_left_edge       = true if pillar.on_left_edge? && grid_x == 0
    self.on_right_edge      = true if pillar.on_right_edge? && pillar.grid_x + column  == pillar.page_ref.column
    self.extended_line_count = 0
    self.pushed_line_count  = 0

    self.save
    create_article_folder
    generate_pdf_with_time_stamp(no_page_pdf: true)
  end

  # def generate_pdf_with_time_stamp
  #   save_article
  #   delete_old_files
  #   stamp_time
  #   system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article .  -time_stamp=#{@time_stamp}"
  # end

  # def generate_pdf
  #   save_story
  #   save_layout
  #   system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  # end
  
  # def page_heading_margin_in_lines
  #   3
  # end

  # def body_line_height
  #   13.5
  # end
  
  def svg_unit_width
    page.svg_unit_width
  end

  def svg_unit_height
    page.svg_unit_height
  end

  def box_svg
    if pillar_order.split("_").length <= 2
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 - 50}' stroke-width='0' ><tspan font-size='100' x='#{x + width/2 - 50}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"
    else
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 - 50}' stroke-width='0' ><tspan font-size='50' x='#{x + width/2 - 25}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"
    end
    svg += "<a xlink:href='/working_articles/#{id}'><rect class='rectfill' stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  end

  def story_svg
    if pillar_order.split("_").length <= 2
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 - 50}' stroke-width='0' ><tspan font-size='100' x='#{x + width/2 - 50}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"
    else
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 - 50}' stroke-width='0' ><tspan font-size='50' x='#{x + width/2 - 25}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"
    end
    svg += "<a xlink:href='/working_articles/#{id}'><rect class='rectfill' stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  end

  # def story_svg
  #   svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 + 50}' stroke-width='0' ><tspan font-size='150' x='#{x + width/2}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='30' x='#{x + width/2}' text-anchor='middle' dy='40'> </tspan></text>"
  #   svg += "<a xlink:href='/working_articles/#{id}/change_story'><rect class='rectfill' stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  # end

  def drop_starting_index
    pillar_order.split('_')[1].to_i - 1
  end

  # create aritcle on the right side which spans from top of current article to the bottom on pillar
  # if current article is not the top article, lock all article above the currnt one.
  def add_right_drop(column_width_in_grid)
    pillar.add_right_drop(column_width_in_grid, drop_starting_index)
  end

  # create aritcle on the left side which spans from top of current article to the bottom on pillar
  # if current article is not the top article, lock all article above the currnt one.
  def add_left_drop(column_width_in_grid)
    pillar.add_left_drop(column_width_in_grid, drop_starting_index)
  end

  def remove_drop
    pillar.remove_drop
  end
end

