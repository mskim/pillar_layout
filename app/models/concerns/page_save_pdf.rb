require 'hexapdf'

module PageSavePdf
  extend ActiveSupport::Concern

  def save_page_pdf(options={})
    pdf_doc = HexaPDF::Document.new
    pdf_page = pdf_doc.pages.add([0, 0, width, height])
    canvas = pdf_page.canvas
    # draw page_headinng
    image_path = page_heading_pdf_path
    if File.exist?(image_path)
      filipped_heading_origin = [left_margin, height - (top_margin + page_heading.height)]
      canvas.image(image_path, at: filipped_heading_origin, width: page_heading.width, height: page_heading.height)
    end
    working_articles.reload
    pillars.sort_by{|p| p.order}.each do |p|
      extended_line_sum = 0
      p.working_articles.each do |w|
        w.draw_article_in_page(canvas, extended_line_sum)
        # do not add attached_type's extended_line_count to extended_line_sum
        extended_line_sum += w.extended_line_count if w.attached_type == nil
      end
    end
    ad_boxes.each do |ad|
      image_path = ad.pdf_path
      if File.exist?(image_path)
        canvas.image(image_path, at: flipped_origin(ad), width: ad.width, height: ad.height)
      end
    end

    pdf_path = path + "/section.pdf"
    pdf_doc.write(pdf_path, optimize: true)
    if options[:time_stamp]
      stamped_path = path + "/section_#{options[:time_stamp]}.pdf"
      system("cp #{pdf_path} #{stamped_path}" )
      convert_pdf2jpg(stamped_path, ratio:2.0)
    end
  end

  def flipped_origin(w)
    if w.top_position?
      [left_margin + w.grid_x*grid_width, height - heading_space - (top_margin  + w.grid_y*grid_height + w.height)]
    else
      [left_margin + w.grid_x*grid_width, height - (top_margin  + w.grid_y*grid_height + w.height)]
    end
  end

end
