 
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
    y_in_lines = row*7 #+ pushed_line_count
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
    page.save_config_file
    page.generate_pdf_with_time_stamp
  end

  def move_to(y_amount, options={})
    self.y_in_lines += y_amount 
    page.save_config_file if options[:update_config_file]
  end

  def move_sibllings_to(position, options={})
    sibs = siblings
    new_pistion = position
    sibs.each do |sibling|
      sibling.move_to(position, update_config_file: false)
      position += sibling.height_in_lines
    end
    layout_last_sibliing(sibs)
    page.save_config_file if options[:update_config_file]
  end

  def move_by(y_amount)
    self.y_in_lines += y_amount 
    page.save_config_file if options[:update_config_file]
  end

  def move_sibllings_by(y_amount, options={})
    sibs = siblings
    sibs.each do |sibling|
      sibling.move_by(y_amount, update_config_file: false)
    end
    layout_last_sibliing(sibs)
    page.save_config_file if options[:update_config_file]
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
 end