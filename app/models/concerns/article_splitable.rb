module ArticleSplitable
  extend ActiveSupport::Concern

  def grid_area
    column*row
  end

  def article_grid_rect
    [grid_x, grid_y, column, row]
  end

  def preferable_direction
    rect = article_grid_rect
    if rect[2] >= rect[3]
      direction = 'vertical'
    else
      direction = 'horizontal'
    end
    direction
  end

  def v_splitable_positions
    spitable_positions = []
    return spitable_positions unless v_splitable?

    case column
    when 2,3
      spitable_positions << -1
    when 4,5
      spitable_positions << -1
      spitable_positions << -2
    when 6,7
      spitable_positions << -1
      spitable_positions << -2
      spitable_positions << -3
    end
    spitable_positions
  end

  def v_splitable?
    column > 1
  end

  def h_splitable?
    row > 1
  end

  def splitable?
    v_splitable? || h_splitable?
  end

  def split_rect(options={})
    rect = article_grid_rect
    if rect[2] < 2 && rect[3] < 2
      puts "article is too small to split!!!"
      return false
    end
    direction = options[:direction]
    direction = preferable_direction     unless direction
    if direction == "vertical" || direction == "v"
      if rect[2] < 2
        puts "article is too small to split!!!"
        return false
      end
      first_width   = rect[2]/2
      second_x      = rect[0] + first_width
      second_width  = rect[2] - first_width
      [[rect[0], rect[1], first_width, rect[3]], [second_x, rect[1], second_width, rect[3]], direction]
    else
      if rect[3] < 2
        puts "article is too small to split!!!"
        return false
      end
      first_height   = rect[3]/2
      second_y       = rect[1] + first_height
      second_height  = rect[3] - first_height
      first_rect     = [rect[0], rect[1], rect[2], first_height]
      second_rect    = [rect[0], second_y, rect[2], second_height]
      [first_rect, second_rect, direction]
    end
  end

  def create_second_article(rect, new_order)
    # nake copy of article for split second article
    second_article_atts = attributes
    second_article_atts.delete('id')
    second_article_atts.delete('article_id')
    second_article_atts.delete('created_at')
    second_article_atts.delete('updated_at')
    second_article_atts.delete('slug')
    second_article_atts['order']  = new_order
    second_article_atts['grid_x'] = rect[0]
    second_article_atts['grid_y'] = rect[1]
    second_article_atts['column'] = rect[2]
    second_article_atts['row']    = rect[3]
    WorkingArticle.create(second_article_atts)
  end

  def update_first_article_grid_rect(new_rect)
    # update size of first split article
    self.grid_x = new_rect[0]
    self.grid_y = new_rect[1]
    self.column = new_rect[2]
    self.row    = new_rect[3]
    self.save
    generate_pdf_with_time_stamp
  end

  def split(options={})
    result = split_rect(options)
    if result
      update_first_article_grid_rect(result[0])
      if result[2] == "v" || result[2] == "vertical"
        new_order = order + 1
      else
        new_order = parent.order_for_new_rect(result[1])
      end
      create_second_article(result[1], new_order)
      parent.insert_new_article_in_page(result[1], new_order) 
    end
  end

  def parent
    if self.class == Article
      section
    elsif self.class == WorkingArticle
      page
    end
  end

end
