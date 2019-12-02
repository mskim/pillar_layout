 
 # autofit siblings with image insertion
 # once siblings unoccuped total area is calculafet
 # and if the unoccuped total area us short
 # so that we need to insert picture, add picture place holder

 # expand and push sibling
 # expand and move sibling 
 
 # autofit and push sibling
 # autofit and move sibling 

 module WorkingArticleAutofit
  extend ActiveSupport::Concern

  def auto_size_image(options={})
    target_image = options[:image] if options[:image]
    unless target_image
      target_image = images.first
    end
    return unless target_image
    image_column = target_image.column
    if empty_lines_count
      size_to_extend = empty_lines_count/image_column
      puts "size_to_extend:#{size_to_extend}"
    elsif overflow_line_count
      size_to_reduce = overflow_line_count/image_column
      puts "size_to_reduce:#{size_to_reduce}"
    end
  end

  def auto_fit_graphic(options={})

  end

  def read_news_box_height
    article_info[:column_line_count]
  end

  def autofit_by_relayout
    options= {}
    options[:article_path] = path
    options[:story_md] = story_md
    options[:layout_rb] = layout_rb
    options[:auto_fit] = 'fit_all'
    maker = RLayout::NewsBoxMaker.new(options)
    new_height_in_lines = read_news_box_height
    puts "new_height_in_lines:#{new_height_in_lines}"
    y_in_lines = row*7 + pushed_line_count
    puts "y_in_lines:#{y_in_lines}"
    new_position = y_in_lines + new_height_in_lines
    move_sibllings_to(new_position)
  end

  def autofit_all_sibllings(options={})
    autofit_by_relayout(options)
    sybs = siblings
    sybs.each do |syb|
      sub_opt                       = {}
      sub_opt[:enough_space]        = true if options[:enough_space] == true
      sub_opt[:update_config_file]  = false
      syb.autofit_by_relayout(sub_opt)
    end
    page.update_config_file
    page.generate_pdf_with_time_stamp
  end

  def move_to(y_amount, options={})
    self.y_in_lines += y_amount 
    page.update_config_file if options[:update_config_file]
  end

  def move_sibllings_to(position, options={})
    sibs = siblings
    new_pistion = position
    sibs.each do |sibling|
      sibling.move_to(position, update_config_file: false)
      position += sibling.height_in_lines
    end
    layout_last_sibliing(sibs)
    page.update_config_file if options[:update_config_file]
  end

  def move_by(y_amount)
    self.y_in_lines += y_amount 
    page.update_config_file if options[:update_config_file]
  end

  def move_sibllings_by(y_amount, options={})
    sibs = siblings
    sibs.each do |sibling|
      sibling.move_by(y_amount, update_config_file: false)
    end
    layout_last_sibliing(sibs)
    page.update_config_file if options[:update_config_file]
  end

  def layout_last_sibliing(sibs)
    # generate_pdf for last siblling
    if sibs.length > 0
      last_sib = sibs.last
      options[:article_path] = last_sib.path
      options[:story_md] = last_sib.story_md
      options[:layout_rb] = last_sib.layout_rb
      result = RLayout::NewsBoxMaker.new(options)
    end
  end

  # old stuff ++++++++++++++++++ 
  def autofit_by_height(options={})
    if overflow?
      proposed_extend = overflow_line_count/column
      plus_line = overflow_line_count % column
      if options[:enough_space]
        proposed_extend += 1 if plus_line > 0
      end
      # move_sibllings_by(proposed_extend, update_config_file:true) if expandable?(proposed_extend)
      extend_line(proposed_extend) if expandable?(proposed_extend)
    elsif underflow?
      proposed_reduce = - empty_lines_count/column
      plus_line = empty_lines_count % column
      if options[:enough_space]
        proposed_reduce += 1 if plus_line > 0
      end
      # move_sibllings_by(proposed_extend) #if expandable?(proposed_extend)

      extend_line(proposed_reduce)
    end
  end

  def autofit_with_sibllings(options={})
    autofit_by_height(options)
    sybs = siblings
    sybs.each do |syb|
      sub_opt                       = {}
      sub_opt[:enough_space]        = true if options[:enough_space] == true
      sub_opt[:update_config_file]  = false
      syb.autofit_by_height(sub_opt)
    end
    page.update_config_file
    page.generate_pdf_with_time_stamp
  end

  def autofit_by_image_size(options={})
    if overflow?
      if images.length > 0
        image = images.first
        proposed_image_reduce = overflow_lines/image.column
      end
    elsif underflow?
      if images.length > 0
        image = images.first
        proposed_image_extemd = empty_lines_count/image.column
      elsif empty_lines_count > 28 && (column > 3 || row > 3)
        # create 2x2
        create_image_place_holder(2,2)
      elsif empty_lines_count > 14 
        if column >= 2
        # create 2x1
          create_image_place_holder(2,1)
        else
          create_image_place_holder(1,2)
        end

      elsif empty_lines_count > 7
        create_image_place_holder(1,1)
      end
      generate_pdf_with_time_stamp    
      page.generate_pdf_with_time_stamp    
    end
  end
  # old stuff ++++++++++++++++++ 

  def autofit_with_time_stamp
    save_article
    delete_old_files
    stamp_time
    ArticleWorker.perform_async(path, @time_stamp, 'fit_all')
    wait_for_stamped_pdf
  end


  def title_area_in_lines
    column*4
  end

  def subtitle_area_in_lines
    3
  end

  def images_area_in_lines
    area = 0
    area += images.map{|img| img.area_in_lines} if images.length > 0
    area
  end

  def graphics_area_in_lines
    area = 0
    area += graphics.map{|img| img.area_in_lines} if images.length > 0
    area
  end

  def quote_area_in_lines
    area = 0
  end

  def total_area_in_lines
    column*row*7
  end

  def available_line_space
    total_area = total_area_in_lines
    total_area += extended_line_count*column if extended_line_count
    total_area -= pushed_line_count*column if pushed_line_count
    occupied_area_in_lines = 0
    occupied_area_in_lines += title_area_in_lines if title
    occupied_area_in_lines += subtitle_area_in_lines if subtitle
    occupied_area_in_lines += images_area_in_lines
    occupied_area_in_lines += graphics_area_in_lines
    occupied_area_in_lines += quote_area_in_lines
    occupied_area_in_lines
    total_area - occupied_area_in_lines
  end

 end