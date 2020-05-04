module ArticleChildrenManager
  extend ActiveSupport::Concern
  def v_cut_children_at(cut_index)
    unless has_children?
      child_column     = cut_index
      if cut_index < 0
        new_column     = column + cut_index
        child_column   = 0 - cut_index
        update(column:new_column)
      else
        changing_column   = column - new_column
        update(grid_x:cut_index, column:changing_column)
      end
      generate_pdf_with_time_stamp
      new_pillar_order = pillar_order + "_1"
      h = {page_id:page.id, pillar:pillar,  pillar_order: new_pillar_order, grid_x:new_column , grid_y: grid_y, column: child_column, row: row }
      w = self.children.create(h)
      w.generate_pdf_with_time_stamp
    else
      puts "already has child!!!"
    end
    page.generate_pdf_with_time_stamp
  end

  # remove last attached article
  def remove_attached_article
    if has_children?
      pillar.box_count    -=  1
      pillar.save
      last_child = chidren.last
      if last_child.grid_x == 0
        # remove left side article
        box_rect    = rect.dup
        box_rect[0] = 0
        box_rect[2] += last_child.column
        last_child.delete_folder
        last_child.destroy
        update(grid_x: 0,column: box_rect[2])
      else
        # remove right side article
        box_rect      = rect.dup
        box_rect[2]   += last_child.column
        update(column: box_rect[2])
      end
    end
    generate_pdf_with_time_stamp
    page_ref.generate_pdf_with_time_stamp
  end

  
  def add_overlap(options={})

  end

  def remove_overlap(overlap)

  end

  def overlap_area
    rect_with_order
  end

end