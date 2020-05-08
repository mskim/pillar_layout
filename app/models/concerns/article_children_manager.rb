module ArticleChildrenManager
  extend ActiveSupport::Concern
  def v_cut_children_at(cut_index)
    unless has_children?
      child_column     = cut_index
      attached_type    = 'right_divide'
      if cut_index < 0
        changing_column  = column + cut_index
        update(column:changing_column)
        child_grid_x     =  changing_column   
        child_column     = 0 - cut_index
      else
        changing_column   = column - cut_index
        update(grid_x:cut_index, column:changing_column)
        child_grid_x      =  0   
        attached_type     = 'left_divide'
      end
      generate_pdf_with_time_stamp
      new_pillar_order = pillar_order + "_1"
      h = {page_id:page.id, pillar:pillar,  pillar_order: new_pillar_order, grid_x:child_grid_x , grid_y: grid_y, column: child_column, row: row, attached_type: attached_type }
      w = self.children.create(h)
      w.generate_pdf_with_time_stamp
      page.generate_pdf_with_time_stamp
    else
      puts "already has child!!!"
    end
  end

  # remove last attached article
  def remove_attached_article
    if has_children?
      pillar.box_count    -=  1
      pillar.save
      last_child = children.last
      if last_child.attached_type == 'right_overlap' || last_child.attached_type == 'left_overlap'
        update(overlap: nil)
      elsif last_child.grid_x == 0
        # remove left side article
        box_rect    = rect.dup
        box_rect[0] = 0
        box_rect[2] = pillar.column

        update(grid_x: 0,column: box_rect[2])
      else
        # remove right side article
        box_rect      = rect.dup
        box_rect[2]   = pillar.column
        update(column: box_rect[2])
      end
      last_child.delete_folder
      last_child.destroy
      generate_pdf_with_time_stamp
      page.generate_pdf_with_time_stamp
    end
  end

  def overlapable?
    column > 3 && row > 3
  end

  def has_overlap?
    attached_type == 'right_overlap' || attached_type == 'left_overlap'
  end

  def add_overlap
    position = 9
    overlap_column    = column/2
    overlap_row       = overlap_row/2
    create_overlap(position, overlap_column, overlap_row)
  end

  def create_overlap(child_position, child_column, child_row)
    child_pillar_order = pillar_order + "_1"
    if child_position == 7
      child_grid_x  = 0 
    elsif child_position == 9
      child_grid_x  = column - child_column
    end
    child_grid_y       = row - child_row
    h = {page_id:page.id, pillar:pillar,  pillar_order: child_pillar_order, grid_x:child_grid_x , grid_y: child_grid_y, column: child_column, row: child_row }
    created_overlap = self.children.create(h)
    update(overlap:created_overlap.rect_with_order)
    generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
  end

  def change_overlap(child_position, child_column, child_row)
    if child_position == 7
      child_grid_x  = 0 
    elsif child_position == 9
      child_grid_x  = column - child_column
    end
    child_grid_y       = row - child_row
    update(grid_x:child_grid_x , grid_y: child_grid_y, column: child_column, row: child_row)
    generate_pdf_with_time_stamp
    parent.update(overlap:changed_overlap.rect_with_order)
    parent.generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
  end

end