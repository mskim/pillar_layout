 module RectUtils
  extend ActiveSupport::Concern

    def min_x(rect)
      rect[0]
    end

    def min_y(rect)
      rect[1]
    end

    def mid_x(rect)
      rect[0] + rect[2]/2
    end

    def mid_y(rect)
      rect[1] + rect[3]/2
    end

    def max_x(rect)
      rect[0] + rect[2]
    end

    def x_max
      @x + @width
    end

    def x_mid
      @x + @width/2
    end

    def y_max
      @y + @height
    end

    def y_mid
      @y + @height/2
    end

    def max_y(rect)
      rect[1] + rect[3]
    end

    def contains_rect(rect_1,rect_2)
      (rect_1[0]<=rect_2[0] && max_x(rect_1) >= max_x(rect_2)) && (rect_1[1]<=rect_2[1] && max_y(rect_1) >= max_y(rect_2))
    end

    def intersects_x(rect1, rect2)
      (max_x(rect1) > rect2[0] && max_x(rect2) > rect1[0]) || (max_x(rect2) > rect1[0] && max_x(rect1) > rect2[0])
    end

    def intersects_y(rect1, rect2)
      (max_y(rect1).to_i > rect2[1].to_i && max_y(rect2).to_i > rect1[1].to_i) || (max_y(rect2).to_i > rect1[1].to_i && max_y(rect1).to_i > rect2[1].to_i)
    end

    def intersects_rect(rect_1, rect_2)
      intersects_x(rect_1, rect_2) && intersects_y(rect_1, rect_2)
    end

    def intersection_rect(rect_1, rect_2)
      int_x = rect_1[0] <= rect_2[0] ? rect_2[0] : rect_1[0]
      int_y = rect_1[1] <= rect_2[1] ? rect_2[1] : rect_1[1]
      x_max = (rect_1[0] + rect_1[2])<= (rect_2[0] + rect_2[2]) ? (rect_1[0] + rect_1[2]) : (rect_2[0] + rect_2[2])
      int_width = x_max - int_x
      y_max = (rect_1[1] + rect_1[3])<= (rect_2[1] + rect_2[3]) ? (rect_1[1] + rect_1[3]) : (rect_2[2] + rect_2[3])
      int_height = y_max - int_y
      [ int_x, int_y, int_width, int_height]
    end

    def y_adjusted_intersection_rect(rect_1, rect_2)
      int_x = rect_1[0] <= rect_2[0] ? rect_2[0] : rect_1[0]
      int_y = rect_1[1] <= rect_2[1] ? rect_2[1] : rect_1[1]
      x_max = (rect_1[0] + rect_1[2])<= (rect_2[0] + rect_2[2]) ? (rect_1[0] + rect_1[2]) : (rect_2[0] + rect_2[2])
      int_width = x_max - int_x
      y_max = (rect_1[1] + rect_1[3])<= (rect_2[1] + rect_2[3]) ? (rect_1[1] + rect_1[3]) : (rect_2[2] + rect_2[3])
      int_height = y_max - int_y
      [ int_x, int_y - rect_1[1], int_width, int_height]
    end

    def union_rect(rect_1, rect_2)
        x = min_x(rect_1) < min_x(rect_2) ? min_x(rect_1) : min_x(rect_2)
        y = min_y(rect_1) < min_y(rect_2) ? min_y(rect_1) : min_y(rect_2)
        bigger_x = max_x(rect_1) > max_x(rect_2) ? max_x(rect_1) : max_x(rect_2)
        width = bigger_x - x
        bigger_y = max_y(rect_1) > max_y(rect_2) ? max_y(rect_1) : max_y(rect_2)
        height = bigger_y - y
        [x,y,width,height]
    end

    def union_rects(rects_array)
        union = rects_array.shift
        rects_array.each do |r|
          union = union_rect(union, r)
        end
        union
    end

    def parse_overlap(rect, i)
      other_box_array = eval_layout
      other_box_array.each_with_index do |other_box, j|
        next if i >= j
        if  intersects_rect(rect,other_box)
          return y_adjusted_intersection_rect(rect,other_box)
        end
      end
      false
    end

    def embeded_rect(rect, other_box)
      rect[0] >= other_box[0] && max_x(rect) <= max_x(other_box) && rect[1] >= other_box[1] && max_y(rect) <= max_y(other_box)
    end

    def parse_embedded(rect, i)
      other_box_array = eval_layout
      other_box_array.each_with_index do |other_box, j|
        next if i <= j
        return true if  embeded_rect(rect, other_box)
      end
      false
    end

end