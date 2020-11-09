 require 'kramdown'
 
 module StaticWorkingArticle
  extend ActiveSupport::Concern

  def static_html_path
    page.static_articles_path + "/#{pillar_order}.html"
  end

  def static_images_folder
    page.static_articles_path + "/images"

  end
  
  def static_html_path
    page.static_articles_path + "/#{pillar_order}.html"
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

  def to_svg_static

  end

  def static_templage_path
    "#{Rails.root}/app/views/working_articles/static_article.html.erb"
  end

  def static_article_image_path

  end

  def images_links
    # TODO:
    ""
  end

  def graphics_links
    # TODO:
    ""
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
    "#{prev_article.pillar_order}.html"
  end

  def page_html
    rjust = (page.page_number).to_s.rjust(4,'0')
    "../#{rjust}.html"
  end

  def next_article_html
    "#{next_article.pillar_order}.html"
  end

  def article_static_content
    @page_number        = page.page_number
    @prev_article_html  = prev_article_html
    @page_html          = page_html
    @next_article_html  = next_article_html
    @images_links       = images_links
    @graphics_links     = graphics_links
    @title              = title
    @subtitle           = subtitle || ""
    @reporter           = @reporter || ""
    @quote              = quote || ""
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