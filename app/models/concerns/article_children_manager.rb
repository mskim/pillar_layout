module ArticleChildrenManager
  extend ActiveSupport::Concern

  # we have tree types of attached articles. 
  # It can position at right or left side
  # drop      right_drop, left_drop
  # divide    right_divide, left_divide
  # overlap   right_overlap, left_overlap

  def addable?
    # can add another article in vertical direction
    # can add article if it is at pillar bottom or if it is a drop_article with row > 2 
    pillar_bottom? || (attached_type =~/drop/ && row > 2)
  end


  def diviable?
    # return false if article is attached one
    # attached article can not be divided nor article which already has attached article
    return false if is_attached_article? || has_divide? || has_drop?
    # dividing parent article column must be larger than 2
    column > 2
  end

  def removeable?
    attached_type || pillar_bottom?
  end

  def is_divide?
    attached_type =~/divide/
  end

  def has_divide?
    has_children? && children.first.is_divide?
  end

  def is_attached_article?
    !attached_type.nil?
  end

  def has_attached_article?
    has_children? && children.first.is_attached_article?
  end

  def divide_at(cut_index)
    unless has_children?
      child_column     = cut_index
      attached_type    = 'right_divide'
      attached_position = '우'
      
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
        attached_position = '좌'
      end
      generate_pdf_with_time_stamp
      new_pillar_order = pillar_order + "_1"
      h = {page_id:page.id, pillar:pillar,  pillar_order: new_pillar_order, grid_x:child_grid_x , grid_y: grid_y, column: child_column, row: row, attached_type: attached_type, attached_position: attached_position}
      w = self.children.create(h)
      w.generate_pdf_with_time_stamp
      page.generate_pdf_with_time_stamp
    else
      puts "already has child!!!"
    end
  end

  def change_divide(new_position, new_column)
    if attached_position != new_position
    # TODO

    end

    if column != new_column
    # TODO

    end

  end

  # remove last attached article
  def remove_attached_article
    if has_children?
      pillar.box_count    -=  1
      pillar.save
      last_child = children.last
      last_child.delete_folder
      last_child.destroy
      generate_pdf_with_time_stamp
      page.generate_pdf_with_time_stamp
    end
  end

  ########## overlap ################

  def overlapable?
    # overlaping parent article column must be large enough
    column > 2 && row > 2
  end

  def is_overlap?
    attached_type == 'overlap'
  end

  def has_overlap?
    has_children? && children.first.is_overlap?
  end

  def possible_overlap_columns
    ['좌','우']
  end

  def add_overlap
    position = 9
    overlap_column    = column/2
    overlap_row       = row/2
    create_overlap(position, overlap_column, overlap_row)
  end

  def create_overlap(child_position, child_column, child_row)
    child_pillar_order = pillar_order + "_1"
    if child_position == 7
      child_grid_x  = grid_x
    elsif child_position == 9
      child_grid_x  =  grid_x + column - child_column
    else
      child_position = 9
      child_grid_x  =  grid_x + column - child_column
    end
    child_grid_y    = grid_y + row - child_row
    h = {page_id:page.id, pillar:pillar,  pillar_order: child_pillar_order, attached_type:'overlap', grid_x:child_grid_x , grid_y: child_grid_y, column: child_column, row: child_row, attached_position:child_position }
    created_overlap = self.children.create(h)
    update(overlap:created_overlap.rect_with_order)
    generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
  end

  def change_overlap(child_position)
    # return if changing params are same as current
    return if position == child_position
    if child_position == '좌'
      child_grid_x  = 0 
    elsif child_position == '우'
      child_grid_x  = column - child_column
    else
      # anything other than 7,9 make it as 9 bottom_right
      child_position = 9
      child_grid_x  = column - child_column
    end
    child_grid_y       = row - child_row
    update(grid_x:child_grid_x , grid_y:child_grid_y, column:child_column, row:child_row, attached_position:child_position)
    generate_pdf_with_time_stamp
    parent.update(overlap:changed_overlap.rect_with_order)
    parent.generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
  end

  ########## drop and split ################
  
  def is_drop?
    attached_type =~/drop/
  end

  def has_drop?
    has_children? && children.first.is_drop?
  end

  def dropable?
    # return false if article is attached one or is at the bottom of pillar
    # these articles can not add drop article to them
    return false if attached_type || pillar_bottom?
    # droping parent article column must be larger than 2
    column > 2 
  end
  
  def drop_splitable?
    # article should be a drop type and row row > 2
    is_drop? && row > 2
  end

  # def add_right_drop  attached_type: right_drop
  # def add_right_drop  attached_type: left_drop
  # they are implemented in pillar.rb

  # split is called at dropped article
  # dropped article creats child 
  def split_drop
    child_row   = row/2
    changing_row = row - child_row
    update(row:changing_row)
    generate_pdf_with_time_stamp
    h           = {}
    h[:attached_type] = "drop_split"
    h[:grid_x]  = grid_x
    h[:grid_y]  = changing_row
    h[:column]  = column
    h[:row]     = child_row
    h[:pillar]  = pillar
    h[:page_id] = page_ref.id
    h[:pillar_order]    = "#{order}_R_1"
    created_drop_split = self.children.create(h)
    w = WorkingArticle.create(h)
    w.generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp  
  end
end