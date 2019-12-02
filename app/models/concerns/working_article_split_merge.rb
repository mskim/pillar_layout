 module WorkingArticleSplitMerge
  extend ActiveSupport::Concern

  def split_article_h
    return if height_in_lines < 14
    new_row = row/2
    new_row +=1 if (row % 2) > 0
    twin_h = {}

    if extended_line_count && extended_line_count != 0
      new_extended_line_count = extended_line_count/2
      new_extended_line_count += (new_extended_line_count % 2) if (new_extended_line_count % 2) > 0
      self.extended_line_count = new_extended_line_count
      twin_h[:extended_line_count] = extended_line_count - new_extended_line_count
    end
    if pushed_line_count && pushed_line_count != 0
      new_pushed_line_count = pushed_line_count/2
      new_pushed_line_count +=1 if (new_pushed_line_count % 2) > 0
      self.pushed_line_count = new_pushed_line_count
      twin_h[:pushed_line_count] = pushed_line_count - new_pushed_line_count
    end

    twin_row = row - new_row
    self.row = new_row
    self.save
    generate_pdf_with_time_stamp
    twin_h[:page_id] = page.id
    twin_h[:order]   = page.articles.length + 1
    twin_h[:grid_x]  = grid_x
    twin_h[:grid_y]  = grid_y
    twin_h[:column]  = grid_y
    twin_h[:row]     = twin_row
    twin_h[:kind]    = kind
    twin_brother = WorkingArticle.create(h)
  end

  def split_article_v
    return if column == 1
    x_mid_point = column/2
    x_mid_point +=1 if (column % 2) > 0
    twin_sister
    h = {}
    h[:page_id]   = page.id
    h[:order]     = page.articles.length + 1
    twin_brother  = WorkingArticle.create(h)
  end
  
  def merge_article

  end



 end