module PageSplitable
  extend ActiveSupport::Concern

  def article_by_size
    sorted_articles = articles.sort_by{|x| x.grid_area}
  end

  def largest_article
    article_by_size.last
  end

  def largest_article_random
    l = largest_article
    largest_collection = article_by_size.select{|x| x.grid_area}
    largest_collection.sample
  end

  def insert_new_article_in_page(second_rect, second_article_order)
    story_frames = eval(self.layout)
    story_frames.insert(second_article_order,second_rect)
    self.layout = story_frames.to_s
    self.save
    bump_up_order_for_rest_of_articles(second_article_order)
    update_page_after_split
  end
  
  def order_for_new_rect(new_rect)
    layout_array    = eval(layout)
    layout_array << new_rect
    sorted_rect = layout_array.sort_by{|rect| [rect[1], rect[0]]}
    order = sorted_rect.index(new_rect)
  end

  def bump_up_order_for_rest_of_articles(new_article_order)
    working_articles.sort_by{|w| w.order}.reverse.each do |wa|
      next if wa.order < new_article_order
      wa.bump_up_path
      wa.order += 1
      wa.save
    end
  end

  def make_profile
    profile = "#{column}x#{row}_"
    profile += "H_" if is_front_page?
    profile += "#{ad_type}_" if ad_type
    profile += story_count.to_s
    profile
  end

  # update order by box position
  def update_working_article_order_by_position
    sorted_box = working_articles.sort_by{|article| [article.grid_y, article.grid_x]}
    sorted_box.each_with_index do |article, i|
      article.order = i + 1
      article.save
    end
  end

  def update_config_yml
    source        = config_path
    config_hash   = YAML::load_file(source)
    config_hash['story_frames'] = eval(layout)
    File.open(source, 'w'){|f| f.write(config_hash.to_yaml)}
  end

  def update_page_after_split
    self.story_count += 1
    self.profile = make_profile
    self.template_id = nil
    self.save
    update_config_yml
    generate_pdf_with_time_stamp
  end
end
