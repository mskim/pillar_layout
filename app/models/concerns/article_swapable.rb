module ArticleSwapable
  extend ActiveSupport::Concern

  def swapable_attributes
    # binding.pry
    atts = attributes.dup
    atts.delete('id')
    atts.delete('create_at')
    atts.delete('updated_at')
    atts.delete('grid_x')
    atts.delete('grid_y')
    atts.delete('column')
    atts.delete('row')
    atts.delete('order')
    atts.delete('on_left_edge')
    atts.delete('on_right_edge')
    atts.delete('is_front_page')
    atts.delete('top_story')
    atts.delete('top_position')
    atts.delete('extended_line_count')
    atts.delete('pushed_line_count')
    atts.delete('on_left_edge')
    atts.delete('on_right_edge')
    atts.delete('article_id')
    atts.delete('page_id')
    atts.delete('path')
    atts.delete('page_heading_margin_in_lines')
    atts.delete('announcement_text')
    atts.delete('announcement_column')
    atts.delete('announcement_color')    
    atts
  end

  def change_story_with(new_story)
    h = new_story[:heading]
    self.subject_head      = h['subject_head'] = subject_head
    self.title             = h['title']
    self.subtitle          = h['subtitle']
    self.quote             = h['quote']
    self.reporter          = h['reporter']
    self.email             = h['email']
    self.body              = new_story[:body]
    self.save
  end

  # swap with first sibling
  def swap
    return unless siblings.length == 1

    self_attributes        = swapable_attributes
    self_images            = images
    self_graphics          = graphics

    target = siblings.first
    target_attributes      = target.swapable_attributes
    target_images          = target.images
    target_graphics        = target.graphics
    self_images.each do |image|
      image.working_article_id = target.id
      image.save
    end
    self_graphics.each do |graphic|
      graphic.working_article_id = target.id
      graphic.save
    end
    target.update(self_attributes)
    target.save
    target.generate_pdf_with_time_stamp

    target_images.each do |image|
      image.working_article_id = id
      image.save
    end
    target_graphics.each do |graphic|
      graphic.working_article_id = id
      graphic.save
    end

    update(target_attributes)
    save
    generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
  end

  # def swap_with(changing_attributes)
  #   puts "++++++++++ in swap_with"
  #   self.update(changing_attributes)
  #   self.save
  #   generate_pdf_with_time_stamp
  # end


  # def swap_with_article_at_order(order)
  #   target = page.working_articles[order - 1]
  #   return unless target
  #   target_attributes      = target.swapable_attributes
  #   target_images          = target.images
  #   target_graphics        = target.graphics
  #   target.swap_with(self)
  #   swap_with(temp)
  #   target_images.each do |image|
  #     image.working_article_id = id
  #   end
  #   target_graphics.each do |graphic|
  #     graphic.working_article_id = id
  #   end
  #   generate_pdf_with_time_stamp
  #   update_page_pdf
  # end

end