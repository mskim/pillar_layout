
module WorkingArticleSavePdf
  extend ActiveSupport::Concern
  attr_reader :heading_obj, :subtitle_obj, :image_objects, :graphic_objects, :quote_object
  

  def flipped_origin
    pillar_flipped_origin = pillar.flipped_origin
    [pillar.x + x, pillar_flipped_origin[1] + pillar.height - y - height]
  end

  # extended_line_sum is used to caculate y_offset
  def draw_article_in_page(page_canvas, extended_line_sum)
    flipped    = flipped_origin
    image_path  = path + "/story.pdf"
    if File.exist?(image_path)
      if !top_position? && (attached_type == 'drop' || attached_type == 'divide')
        # this is for side_drop starting not at the top, but in the middle
        pushed_line_count = pillar.extened_line_sum_for_previous_root_articles(grid_y)
        self.pushed_line_count = pushed_line_count
        self.save
        h = row * grid_height
        h -= pushed_line_count* body_line_height
        flipped[1] += pushed_line_count*body_line_height
        page_canvas.image(image_path, at: flipped, width: width, height: h)
      
      elsif attached_type == 'overlap'
        h = row * grid_height
        h += extended_line_count*body_line_height
        flipped[1] += extended_line_count*body_line_height
        page_canvas.image(image_path, at: flipped, width: width, height: h)
      elsif pillar_bottom? && !top_position?
        pushed_line_count = pillar.extened_line_sum
        self.pushed_line_count = pushed_line_count
        self.save
        h = row * grid_height
        # h -= extended_line_sum * body_line_height
        # flipped[1] += extended_line_sum*body_line_height
        h -= pushed_line_count* body_line_height
        flipped[1] += pushed_line_count*body_line_height
        page_canvas.image(image_path, at: flipped, width: width, height: h)
      else
        if parent
          # handle overlap
          # todo ???? we alerad have overlap abobe !!!! merge this!!!!!
          sum = pillar.extened_line_sum_for_previous_root_articles(grid_y)
          flipped[1] -= pillar.extened_line_sum_for_previous_root_articles(grid_y)*body_line_height if sum
        else
          flipped[1] -= extended_line_sum*body_line_height
        end
        page_canvas.image(image_path, at: flipped, width: width, height: height)
      end
    else
      puts "missing image_path :#{image_path} !!!"
    end

    if page.draw_divider

      if attached_type == 'drop' || attached_type == 'divide'
        if attached_position == '좌'
          starting_x = flipped[0] + width
          starting_y = flipped[1]
          ending_x   = starting_x
          ending_y   = flipped[1] + height
          page_canvas.line_width(0.3)
          page_canvas.stroke_color(0, 0, 0, 254).line(starting_x, starting_y, ending_x, ending_y).stroke
          if !on_left_edge
            starting_x = flipped[0]
            ending_x = flipped[0]
            page_canvas.stroke_color(0, 0, 0, 254).line(starting_x, starting_y, ending_x, ending_y).stroke
          end
        else
          starting_x = flipped[0]
          starting_y = flipped[1]
          ending_x   = starting_x
          ending_y   = flipped[1] + height
          if pillar_bottom?
            starting_y = flipped[1] + body_line_height*2
            ending_y   = flipped[1] + height - body_line_height
          elsif top_position?
            ending_y   = flipped[1] + height - body_line_height
          end
          page_canvas.line_width(0.3)
          page_canvas.stroke_color(0, 0, 0, 254).line(starting_x, starting_y, ending_x, ending_y).stroke
          if !on_right_edge?
            starting_x = flipped[0] + width
            ending_x = flipped[0] + width
            page_canvas.stroke_color(0, 0, 0, 254).line(starting_x, starting_y, ending_x, ending_y).stroke
          end
        end

      elsif attached_type == 'overlap' 

      elsif !on_right_edge?
        starting_x = flipped[0] + width
        starting_y = flipped[1]
        ending_x   = starting_x
        ending_y   = flipped[1] + height
        page_canvas.line_width(0.3)
        if pillar_bottom?
          starting_y = flipped[1] + body_line_height*2
        elsif top_position?
          ending_y   = flipped[1] + height - body_line_height
        end
        page_canvas.stroke_color(0, 0, 0, 254).line(starting_x, starting_y, ending_x, ending_y).stroke
      end
    end
  end

end