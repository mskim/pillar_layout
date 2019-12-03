
module WorkingArticlePillarMethods
  extend ActiveSupport::Concern
  
  def path
    if pillar_member?
      page.path + "/#{pillar_order.split("_").join("/")}"
    else
      page.path + "/#{pillar_order}"
    end 
  end

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

  def pillar_member?
    pillar_order.include?("_")
  end

  def bottom_member?
    bottom == pillar.row
  end

  def bottom
    grid_y + row
  end

  def adjustable_height?
    return true unless bottom_member?
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

  def create_article_folder
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end

  def change_article(box_info)
    move_it
    h = {}
    h = {}
    h[:grid_x] = box_info[0]
    h[:grid_y] = box_info[1]
    h[:column] = box_info[2]
    h[:row]    = box_info[3]
    h[:pillar_order]  = box_info[4]
    update(h)
    create_article_folder
    restore
    generate_pdf_with_time_stamp
  end

  def generate_pdf_with_time_stamp
    save_article
    delete_old_files
    stamp_time
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article .  -time_stamp=#{@time_stamp}"
    update_pdf_chain
    # wait_for_stamped_pdf
  end

  def generate_pdf
    save_story
    save_layout
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
    update_pdf_chain
  end

  def update_pdf_chain
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
  
  def merge_children_pdf(path_from_root)
    folder = page.path
    if path_from_root == ""
      # output = folder + "/section.pdf"
      # pillst top level will be merged whth other pillars whem page is merged
    else
      # puts "path_from_root:#{path_from_root}"
      depth = path_from_root.split("/").length
      direction = depth.odd? ? 'vertical' : 'horizontal'
      # puts "direction:#{direction}"
      folder += "/#{path_from_root}"
      output = folder + "/story.pdf"
      pdfs = Dir.glob("#{folder}/*/story.pdf").sort 
      if depth == 1
        # if depth == 0
        # this is when it is at the top pillar
        # pillar box size should be kept and pdfs should aling from top
        stack_pdf(pdfs, output, direction)
      else
        merge_pdf(pdfs, output, direction)
      end
    end
  end
  
  def page_heading_margin_in_lines
    3
  end

  def body_line_height
    13.5
  end
  
  def svg_unit_width
    page.svg_unit_width
  end

  def svg_unit_height
    page.svg_unit_height
  end

  def x
    if pillar
      pillar.x + grid_x*grid_width
    else
      grid_x*grid_width
    end
  end
  
  def pillar_x
    grid_x*grid_width
  end

  def y
    y_position =  grid_y*grid_height
    if top_position?
      y_position += page_heading_margin_in_lines*body_line_height
    # elsif pushed_line_count && pushed_line_count != 0
    #   y_position += pushed_line_count*body_line_height
    end
    y_position
  end

  def pillar_svg
    svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 + 20}' stroke-width='0' ><tspan font-size='100' x='#{pillar_x + width/2}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' x='#{x + width/2}' text-anchor='middle' dy='40'> </tspan></text>"
    svg += "<a xlink:href='/working_articles/#{id}'><rect class='rectfill' stroke='black' stroke-width='0' fill-opacity='0.0' x='#{pillar_x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  end

  def box_svg
    svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 + 20}' stroke-width='0' ><tspan font-size='100' x='#{x + width/2}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' x='#{x + width/2}' text-anchor='middle' dy='40'> </tspan></text>"
    svg += "<a xlink:href='/working_articles/#{id}'><rect class='rectfill' stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  end

  private
  def init_article
    self.column = 4 unless column
    self.row = 4 unless row
    self.title = "여기는 #{pillar_order}제목 입니다." unless title
    self.title = "여기는 #{pillar_order}제목." if column <= 2
    self.subtitle = '여기는 부제목 입니다.' unless subtitle
    body_text = '여기는 본문입니다. '*20 
    body_text += '여기는 본문입니다. '*20 
    body_text =<<~EOF
    #{body_text}

    #{body_text}

    #{body_text}

    EOF
    self.body = body_text unless body
  end

  def setup_article
    FileUtils.mkdir_p(path) unless File.exist?(path)
    make_images_directory
    save_story
    save_layout
    generate_pdf_with_time_stamp
  end
end

