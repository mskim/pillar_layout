# How to auto size image and graphic

1. limitation on how to enlarge
    - restricted column and adjust height only within grid
    - enlarge column and height

2. when we have multiple image?
    - how do you select one to enlarge?

3. when we have multiple image and graphic?
    - how do you select one to enlarge?

4. Do we make text overflow or underflow 
    - Do we need to reduce size, when text overflows ?
  
def calculate_fitting_image_size(image_column, image_row, image_extra_line)
    image_area = image_column*image_row*7 + image_extra_line*image_column
    if overflow_lines > 0
      over_flow_rows    = (overflow_lines/image_column).to_i
      over_extra_lines  = overflow_lines%image_column

      if overflow_lines >  than image_area,
        [1,1,0]
      elsif  image_row + over_flow_rows > row
        reduce_rows = image_row + over_flow_rows - row
        [image_column, image_row - reduce_rows, 0]
      else
        [image_column, image_row + over_flow_row, over_extra_lines]
      end
    else
      add_rows = image_row + (overflow_lines/image_column).to_i
      add_extra_lines  = overflow_lines%image_column
      [image_column, image_row + add_rows, add_extra_lines]
    end

end 