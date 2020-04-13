
module WorkingArticleSavePdf
  extend ActiveSupport::Concern
  attr_reader :heading_obj, :subtitle_obj, :image_objects, :graphic_objects, :quote_object
  
  #TODO generate pdf without saving things to file
  def layout_article
    @pdf_doc      = HexaPDF::Document.new
    page          = @pdf_doc.pages.add([0, 0, width, height])
    canvas        = page.canvas

    create_news_article
    create_heading
    create_subtitle
    create_images
    create_graphics
    create_announcement
    arrange_floats
    create_body
    draw_body(canvas)
    draw_floats(canvas)
    output_path   = path + "/story_from_ruby.pdf"
    @pdf_doc.write(output_path)
    t = Time.now
  end

  def create_news_article

  end

  # make heading as float
  def create_heading(options={})
    h = {}
    h[:is_float]      = true
    h[:parent]        = self
    h[:column_count]  = column
    h[:x]             = @starting_column_x
    h[:y]             = 0
    h[:width]         = @width - 2
    h[:width]         = @width - @gutter unless @on_left_edge
    h[:width]         = @width - @gutter unless @on_right_edge
    h[:width]         = @heading_columns*@column_width + (@heading_columns - 1)*@gutter if @heading_columns != @column_count
    h[:subtitle_type] = @subtitle_type
    @stroke.thickness = 0.3
    case @kind
    when 'editorial', "사설"
      @stroke[:sides] = [1,1,1,1]
      if @has_profile_image
        h[:width] -= @gutter
      else
        h[:width] -= @left_inset  + @right_inset
      end
      @heading = NewsHeadingForEditorial.new(h)
    when 'opinion', "기고"
      # for 2 column opinion
      # we want to put heading on top as 2 column heading, before personal image
      # putting on the right side of image, head space would be too short
      @stroke[:sides] = [0,1,0,1]
      h[:x]     += @left_margin + @column_width + @gutter
      h[:y]     = 2
      if @column_count == 2 
        h[:x]     = @left_margin
        h[:width] -= @left_margin
        h[:column_count] = 2
      else
        h[:width] -= (h[:x] + @right_inset + @right_margin )
      end
      @heading = NewsHeadingForOpinion.new(h)
      if @profile_image_position == "하단 오른쪽"
        subject_head(options)
      end
    when 'box_opinion'
      @stroke[:sides]     = [1,2,1,1]
      h[:y]     = @body_line_height
      if @on_right_edge
        h[:x]     = @gutter*2
        h[:width] -=@gutter*2
      elsif @on_left_edge
        h[:x]     = @gutter
        h[:width] -=@gutter*2
      end
      @heading = NewsHeadingForArticle.new(h)
    when 'obituary_promotion', '부고-인사'
      @heading = NewsHeadingForObituary.new(h)
    when '특집', '책소개'
      @heading          = NewsHeadingForArticle.new(h)
    else
      @stroke[:sides] = [0,0,0,1]
      @stroke.thickness = 0.3
      @heading = NewsHeadingForArticle.new(h)
      if  @column_count != @heading_columns
        # make top margin at the right side of shortened heading
        place_holder_options               = {}   
        place_holder_options[:is_float]    = true
        place_holder_options[:parent]      = self
        place_holder_options[:x]           = @heading_columns*@column_width + (@heading_columns - 1)*@gutter #if @heading_columns != @column_count
        # place_holder_options[:x]           = @column_width*4 + @gutter*4
        place_holder_options[:y]           = 0
        place_holder_options[:width]       = @column_width*(@column_count - @heading_columns) + @gutter*(@column_count - @heading_columns - 1)
        place_holder_options[:height]      = @body_line_height*2
        @heading_right_side_one_line_space = Rectangle.new(place_holder_options)
      end
    end
    # check if we have 2 단 기고
    # put heading after personal image
    if @kind == "기고" && @column_count == 2
      unless @heading == @floats[1]
        # make heading as second one in floats
        @heading = @floats.pop
        @floats.insert(1,@heading)
      end
    else
      if @floats.first.class == NewsImage && @floats.first.position.to_i == 0

      elsif @heading != @floats.first
        # make heading as first one in floats
        @heading = @floats.pop
        @floats.unshift(@heading)
      end
    end
  end


  def create_subtitle

  end

  def create_images

  end

  def create_graphics

  end

  def create_announcement

  end
  
  def arrange_floats
    puts __method__
  end

  def create_body
    create_paragraphs
  end

  def draw_body(canvas)
    puts __method__
  end

  def draw_floats(canvas)
    puts __method__
    draw_heading(canvas)      if title && title != ""
    draw_subtitle(canvas)     if subtitle && subtitle != ""
    draw_images(canvas)       if images.length > 0
    draw_graphics(canvas)     if graphics.length > 0
    draw_quote(canvas)        if quote && quote != ""
    draw_announcement(canvas) if announcement_text && announcement_text != ""

  end

  def draw_heading(canvas)
    puts __method__
  end

  def draw_subtitle(canvas)
  end

  def draw_images(canvas)
    puts __method__
  end

  def draw_graphics(canvas)
    puts __method__
  end

  def draw_quote(canvas)
    puts __method__  
  end

  def draw_announcement(canvas)
    puts __method__
  end

  def flipped_origin
    pillar_flipped_origin = pillar.flipped_origin
    [pillar.x, pillar_flipped_origin[1] + pillar.height - y - height]
  end

  # extended_line_sum is used to caculate y_offset
  def draw_article_in_page(page_canvas, extended_line_sum)
    # binding.pry
    flipped    = flipped_origin
    image_path  = path + "/story.pdf"

    if pillar_bottom?
      h = row * grid_height
      h -= extended_line_sum * body_line_height
      if File.exist?(image_path)
        page_canvas.image(image_path, at: flipped, width: width, height: h)
      else
        puts "missing image_path :#{image_path} !!!"
      end
    else
      flipped[1] -= extended_line_sum*body_line_height
      if File.exist?(image_path)
        page_canvas.image(image_path, at: flipped, width: width, height: height)
      else
        puts "missing image_path :#{image_path} !!!"
      end    
    end
    if page.draw_divider && !on_right_edge
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