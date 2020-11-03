 module StaticWorkingArticle
  extend ActiveSupport::Concern

  def static_html_path
    page.static_articles_path + "/#{pillar_order}.html"
  end

  def static_html_path
    page.static_articles_path + "/#{pillar_order}.html"
  end

  def static_image_path
    page.static_articles_path + "/images/#{pillar_order}.jpg"
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

  def images_links
    ""
  end

  def graphics_links
    ""
  end

  def article_static_content
    @pictures_links = images_links
    @graphics_links = graphics_links
    template = File.open(static_templage_path, 'r'){|f| f.read}
    erb = ERB.new(template)
    erb.result(binding)
  end

  def create_static_working_article
    copy_working_article_image_to_static
    File.open(static_html_path, 'w'){|f| f.write article_static_content}
  end

  def copy_working_article_image_to_static
    system("cp #{jpg_image_path} #{static_image_path}/")
  end


  def html_header
    layout =<<~EOF
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Document</title>
    </head>
    <body>
  
    EOF
  end

  def html_body
    content =""
    content += "<h2>#{title}</h3>\n"
    content += "<h4>#{subtitle}</h4>\n"
    content += "<h5>#{reporter}</h5>\n"
    content += "<p>#{body}</p>\n"
    content
  end

  def to_html
    h = html_header
    h += html_body
    h +=" </body>"
    h +="</html>"
  end

  def save_html
    page_folder = File.dirname(html_path)
    FileUtils.mkdir_p(page_folder) unless File.exist?(page_folder)
    File.open(html_path, 'w'){|f| f.write to_html}
  end

  def save_html_image
    page_folder = File.dirname(html_image_path)
    FileUtils.mkdir_p(page_folder) unless File.exist?(page_folder)
    FileUtils.cp(jpg_path, html_image_path)
  end

  def box_svg_html
    if pillar_order.split("_").length <= 2
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 - 50}' stroke-width='0' ><tspan font-size='100' x='#{x + width/2 - 50}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"
    else
      svg = "<text fill-opacity='0.5' fill='#777' y='#{y + height/2 - 50}' stroke-width='0' ><tspan font-size='50' x='#{x + width/2 - 25}' text-anchor='middle'>#{pillar_order}</tspan><tspan font-size='10' y='#{y + height/2}' text-anchor='middle' dy='40'> </tspan></text>"
    end
    svg += "<a xlink:href='/working_articles/#{id}/show_html'><rect class='rectfill' stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  end

 end