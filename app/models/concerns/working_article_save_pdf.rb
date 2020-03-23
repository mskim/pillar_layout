
module WorkingArticleSavePdf
  extend ActiveSupport::Concern
  # attr_reader :heading_obj, :subtitle_obj, :image_objects, :graphic_objects, :quote_object
  
  #TODO generate pdf without saving things to file
  def save_article_with_ruby
    @pdf_doc      = HexaPDF::Document.new
    page          = @pdf_doc.pages.add([0, 0, width, height])
    canvas        = page.canvas
    create_heading
    create_subtitle
    create_images
    create_graphics
    create_announcement
    arrange_floats
    draw_body(canvas)
    draw_floats(canvas)
    output_path   = path + "/story_from_ruby.pdf"
    @pdf_doc.write(output_path)
    t = Time.now
  end

  def create_heading
    puts __method__
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

  def filipped_origin
    pillar_flipped_origin = pillar.filipped_origin
    [pillar.x, pillar_flipped_origin[1] + pillar.height - y - height]
  end

  # extended_line_sum is used to caculate y_offset
  def draw_article_in_page(page_canvas, extended_line_sum)
    filipped    = filipped_origin
    filipped[1] -= extended_line_sum*body_line_height
    image_path  = path + "/story.pdf"
    page_canvas.image(image_path, at: filipped, width: width, height: height)
  end
end