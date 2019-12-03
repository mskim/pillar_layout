module PageSvg
  extend ActiveSupport::Concern

  def svg_unit_width
    150/column
  end

  def svg_unit_height
    15
  end

  def has_heading?
    page_number == 1
  end

  def number_of_chars(box_y, box_width, box_height, has_image)
    lines_in_box    = box_width*box_height*7  #total_lines
    lines_in_box    -= box_width*4            #lines_in_heading
    lines_in_box    -= 3                      #lines_in_subtitle
    lines_in_box    -= 2*2*7 if has_image     #lines_in_image
    lines_in_box    -= box_width*2            #lines_at_bottom
    if has_heading? && box_y == 1
      lines_in_box    -= box_width*4            #lines_at_front_page heading
    elsif box_y == 0
      lines_in_box    -= box_width*3            #lines_at_front_page heading
    end

    case column
    when 5
      char_count_per_line = 18
    when 6
      char_count_per_line = 17
    when 7
      char_count_per_line = 16
    end
    char_count = lines_in_box*char_count_per_line
    #round off to 100 units
    char_count -= char_count % 100
  end

  def svg_box
    # TODO put story number on top
    # make width for 6 column same as 7 column
    string = ""
    layout.each do |box|
      next if box.class == Hash
      if box.length == 5
        if box[4] == 'heading' || box[4] == '제목'
          # heading box
          string += "<rect fill='white' stroke='#000000' x='#{box[0]*svg_unit_width}' y='#{box[1]*svg_unit_height}' width='#{box[2]*svg_unit_width}' height='#{box[3]*svg_unit_height}'/>\n"
        elsif box[4] == 'image'
          puts "place image here ..."
        elsif box[4] && box[4] =~/광고/
          # ad box
          string += "<rect fill='lightGray' stroke='#000000' x='#{box[0]*svg_unit_width}' y='#{box[1]*svg_unit_height}' width='#{box[2]*svg_unit_width}' height='#{box[3]*svg_unit_height}'/>\n"
        else
          # char_count = number_of_chars(box[1],box[2], box[3], false)
          # string += "<rect fill='white' stroke='#000000' stroke-width='4' x='#{box[0]*svg_unit_width}' y='#{box[1]*svg_unit_height}' width='#{box[2]*svg_unit_width}' height='#{box[3]*svg_unit_height}'/>\n"
          # string += "<text x='#{box[0]*svg_unit_width + 10} 'y='#{box[1]*svg_unit_height + 20}' stroke-width='0' class='small'>#{char_count}</text>"
          # if box[2] >3 && box[3]>3
          #   char_count = number_of_chars(box[1], box[2], box[3], true)
          #   string += "<text x='#{box[0]*svg_unit_width + 10}'y='#{box[1]*svg_unit_height + 40}' stroke-width='0' class='small'>#{char_count}(사진)</text>"
          # end
        end
      else
        # char_count = number_of_chars(box[1],box[2], box[3], false)
        # string += "<rect fill='white' stroke='#000000' stroke-width='4' x='#{box[0]*svg_unit_width}' y='#{box[1]*svg_unit_height}' width='#{box[2]*svg_unit_width}' height='#{box[3]*svg_unit_height}'/>\n"
        # string += "<text x='#{box[0]*svg_unit_width + 3}'y='#{box[1]*svg_unit_height + 12}' stroke-width='0' class='small' fill='CornflowerBlue'>#{char_count}</text>"
        # if box[2] >3 && box[3]>3
        #   char_count = number_of_chars(box[1], box[2], box[3], true)
        #   string += "<text x='#{box[0]*svg_unit_width + 3}'y='#{box[1]*svg_unit_height + 22}' stroke-width='0' class='small' fill='Coral'>#{char_count}(사진)</text>"
        # end

       end
    end
    string
  end

  def to_svg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0' y='0' stroke='black' stroke-width='4' width='#{column*svg_unit_width}' height='#{row*svg_unit_height}'>
      #{svg_box}
    </svg>
    EOF
  end

  def page_svg_with_jpg
    "<image xlink:href='#{jpg_image_path}' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />\n"
  end


  def page_svg_with_pdf
    "<image xlink:href='#{pdf_image_path}' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />\n"
  end

  def box_svg_with_jpg
    # +++++ using pdf image for now
    box_element_svg = page_svg_with_pdf
    box_element_svg += "<g transform='translate(#{doc_left_margin},#{doc_top_margin})' >\n"
    # box_element_svg += page_svg
    # box_element_svg += page_heading.box_svg if page_number == 1
    working_articles.each do |article|
      # next if article.inactive
      box_element_svg += article.box_svg
    end
    ad_boxes.each do |ad|
      box_element_svg += ad.box_svg
    end
    box_element_svg += '</g>'
    box_element_svg
  end

  def doc_width
    # publication.width
    width + left_margin + right_margin
  end

  def page_width
    # publication.page_width
    width
  end

  def doc_height
    # publication.height
    height + top_margin + bottom_margin
  end

  def doc_left_margin
    # publication.left_margin
    left_margin
  end

  def doc_top_margin
    # publication.top_margin
    top_margin
  end

  def page_height
    # publication.page_height

    height
  end

  def page_heading_width
    width
    # publication.page_heading_width
  end

  def to_svg_with_jpg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{doc_width} #{doc_height}' >
      <rect fill='white' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />
      #{box_svg_with_jpg}
    </svg>
    EOF
  end

  def to_svg_with_pdf
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{doc_width} #{doc_height}' >
      <rect fill='white' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />
      #{box_svg_with_jpg}
    </svg>
    EOF
  end


end
