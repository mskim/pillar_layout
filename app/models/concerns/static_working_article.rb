 require 'kramdown'
 
 module StaticWorkingArticle
  extend ActiveSupport::Concern

  def static_html_path
    page.static_articles_path + "/#{pillar_order}.html"
  end

  def static_images_folder
    page.static_articles_path + "/images"

  end
  
  def static_jpg_path
    page.static_articles_path + "/images/#{pillar_order}.jpg"
  end

  def static_pdf_path
    page.static_articles_path + "/images/#{pillar_order}.pdf"
  end

  def static_image_url
    page.static_articles_url + "/images/#{pillar_order}.jpg"
  end

  def static_article_links
    # TODO link to article  ???
    "<a xlink:href='#{page.rjusted_page_number}/#{pillar_order}.html'><rect class='rectfill' stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  end

  def static_templage_path
    "#{Rails.root}/app/views/working_articles/static_article.html.erb"
  end

  def images_links
    s = ""
    images.each do |i| 
      s += i.to_html
    end
    s
  end

  def graphics_links
    s = ""
    graphics.each do |i| 
      s += i.to_html
    end
    s
  end

  def body_content
    s = body
    # remove reporter line from body
    @reporter = s.match(/^# (.+)/)
    if @reporter 
      # TODO: get rid of '# ' from match, for now do the following
      @reporter = @reporter[0].sub("# ", "") 
      s = s.gsub(/^# .+/, "")
    end
    s = s.gsub("### ", "##### ")
    s = s.gsub("## ", "#### ")
    html = Kramdown::Document.new(s).to_html
  end

  def prev_article
    page.prev_article(self)
  end

  def next_article
    page.next_article(self)
  end

  def prev_article_html
    if prev_article == self
      if page.page_number == 1
        # at first article of first page
        "#{pillar_order}.html"
      else
        prev_p = page.prev_page
        if prev_p
          p_order = prev_p.first_article.pillar_order
          rjust = (prev_p.page_number + 1).to_s.rjust(4,'0')
          "../#{rjust}/#{p_order}.html"
        else
          "#{pillar_order}.html"
        end
      end
    else
      "#{prev_article.pillar_order}.html"
    end
  end

  def page_html
    rjust = (page.page_number).to_s.rjust(4,'0')
    "../#{rjust}.html"
  end

  def next_article_html
    if next_article == self
      if page.last_page?
        # at last article of last page
        "#{pillar_order}.html"
      else
        # at last article of mid page
        next_p = page.next_page
        if next_p && next_p.page_has_articles?
          p_order = next_p.first_article.pillar_order
          rjust = (next_p.page_number + 1).to_s.rjust(4,'0')
          "../#{rjust}/#{p_order}.html"
        else
          "#{pillar_order}.html"
        end
      end
    else
      "#{next_article.pillar_order}.html"
    end
  end

  def korean_date
    date = page.issue.date
    "#{date.year}년 #{date.month}월 #{date.day}일"
  end

  def article_static_content
    @page_number        = page.page_number
    @prev_article_html  = prev_article_html
    @page_html          = page_html
    @next_article_html  = next_article_html
    @title              = title
    @subtitle           = subtitle || ""
    @korean_date        = korean_date
    @reporter           = @reporter || ""
    @quote              = quote || ""
    @images_links       = images_links
    @graphics_links     = graphics_links
    @body_content       = body_content
    template            = File.open(static_templage_path, 'r'){|f| f.read}
    erb                 = ERB.new(template)
    erb.result(binding)
  end

  def create_static_working_article
    copy_working_article_assets_to_static
    # write static_html_path
    File.open(static_html_path, 'w'){|f| f.write article_static_content}
  end

  def copy_working_article_assets_to_static
    FileUtils.mkdir_p(static_images_folder) unless File.exist?(static_images_folder)
    # copy_working_article_jpg_to_static
    system("cp #{jpg_path} #{static_jpg_path}")
    # copy_working_article_jpg_to_static
    system("cp #{pdf_path} #{static_pdf_path}")
    # copy images to static
    images.each do |image|
      image.copy_image_to_static
    end
    # copy graphics to static
    graphics.each do |graphic|
      graphic.copy_graphic_to_static
    end
  end

  def box_svg_html
    if pillar_order.split("_").length <= 2
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 - 50}' stroke-width='0' ><tspan font-size='100' x='#{x + width/2 - 50}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"
    else
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 - 50}' stroke-width='0' ><tspan font-size='50' x='#{x + width/2 - 25}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"
    end
    svg += "<a xlink:href='#{page.rjusted_page_number}/#{pillar_order}.html'><rect class='rectfill' stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  end

 end