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
      canvas.image(image_path, at: filipped_origin(page_heading), width: page_heading.width, height: page_heading.height)
    end
    pillars.sort_by{|p| p.order}.each_with_index do |p,i|
      image_path = path + "/#{i + 1}/story.pdf"
      puts "image_path:#{image_path}"
      height_shift  = 0
      if File.exist?(image_path)
        canvas.image(image_path, at: p.filipped_origin, width: p.width, height: p.height - height_shift)
      else
        puts "File not found !!!!:#{image_path}"
      end
    end

    ad_boxes.each do |ad|
      image_path = ad.pdf_path
      if File.exist?(image_path)
        canvas.image(image_path, at: filipped_origin(ad), width: ad.width, height: ad.height)
      end
    end

    pdf_path = path + "/section.pdf"
    pdf_doc.write(pdf_path, optimize: true)
    if options[:time_stamp]
      stamped_path = path + "/section_#{options[:time_stamp]}.pdf"
      system("cp #{pdf_path} #{stamped_path}" )
    end
  end

  def filipped_origin(w)
    [left_margin + w.grid_x*grid_width, height - (top_margin  + w.grid_y*grid_height + w.height)]
  end
  
  def stack_pdf(pdf_files, output, direction)
    if pdf_files.length == 0
      puts "pdf_files count == 0 at: output :#{output}"
      return 
    end
    config_path     = File.dirname(File.dirname(pdf_files.first)) + "/pillar_config.yml"
    pillar_config   = YAML::load_file(config_path)
    doc_width  = pillar_config[:width]
    doc_height = pillar_config[:height]

    image_pages = []
    pdf_files.each do |file|
      pdf = HexaPDF::Document.open(file)
      box = pdf.pages[0].box
      info = [box.width.dup, box.height.dup, file]
      image_pages << info
    end
    doc = HexaPDF::Document.new
    pdf_page = doc.pages.add([0, 0, doc_width, doc_height])
    canvas = pdf_page.canvas
    y = doc_height
    image_pages.each do |image_info|
      # canvas.image(image_path, at: [350, -300], height: 200)
      x = 0
      #TODO ??????
      canvas.image(image_info[2], at: [x, y - image_info[1]], height: image_info[1])
      y -= image_info[1]
    end
    doc.write("#{output}", optimize: true)
  end

  def merge_pdf(pdf_files, output, direction)
    # get pdf image size    
    image_pages = []
    pdf_files.each do |file|
      pdf = HexaPDF::Document.open(file)
      box = pdf.pages[0].box
      info = [box.width.dup, box.height.dup, file]
      image_pages << info
    end

    
    # layout images vertically or horizontally
    if direction == 'vertical'
      doc_width = image_pages.map{|i| i[0]}.max
      doc_height = image_pages.map{|i| i[1]}.reduce(:+)
      doc = HexaPDF::Document.new
      page = doc.pages.add([0, 0, doc_width, doc_height])
      canvas = page.canvas
      y = doc_height
      image_pages.each do |image_info|
        # canvas.image(image_path, at: [350, -300], height: 200)
        canvas.image(image_info[2], at: [0, y - image_info[1]], height: image_info[1])
        y -= image_info[1]
      end
    else
      doc_width = image_pages.map{|i| i[0]}.reduce(:+) 
      doc_height = image_pages.map{|i| i[1]}.max
      doc = HexaPDF::Document.new
      page = doc.pages.add([0, 0, doc_width, doc_height])
      canvas = page.canvas
      x = 0
      y = doc_height
      image_pages.each do |image_info|
        canvas.image(image_info[2], at: [x, y - image_info[1]], height: image_info[1])
        x += image_info[0] + 10*2 #gutter
      end
    end
    # syste m("touch #{output}")
    doc.write("#{output}", optimize: true)
  end

end
