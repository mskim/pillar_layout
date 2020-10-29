module StaticPage
  extend ActiveSupport::Concern

  def rjusted_page_number
    page_number.to_s.rjust(4,'0')
  end

  def static_path
    issue.static_path + "/#{rjusted_page_number}"
  end
  
  def static_articles_path
    issue.static_path + "/#{rjusted_page_number}"
  end


  def static_articles_url
    "/#{rjusted_page_number}"
  end
  

  def static_html_path
    issue.static_path + "/#{rjusted_page_number}.html"
  end

  def static_jpg_path
    static_html_path + "/images/#{rjusted_page_number}.jpg"
  end

  def static_jpg_url
    "images/#{rjusted_page_number}.jpg"
  end

  def static_page_template_path
    "#{Rails.root}/app/views/pages/static_page.html.erb"
  end

  def static_page_conent
    @articles = working_article.map{|w| w.static_article_links}
    template = File.open(static_page_template_path, 'r'){|f| f.read}
    erb = ERB.new(template)
    erb.result(binding)
  end

  def create_static_page
    FileUtiles.mkdir_p(static_path) unless File.exist?(static_path)
    File.open(static_html_path 'w'){|f| f.write static_page_conent}
    create_static_articles
  end

  def create_static_articles
    working_articles.each do |w|
      w.create_static_working_article
    end
  end

  def to_svg_static
    
  end

  def save_html 
    if section_name == "전면광고"
      ad = ad_boxes.first
      ad.order = 1
      ad.save
      ad.save_html
    else
      working_articles.each do |article|
        article.save_html
      end
      ad_boxes.each do |ad|
        ad.order = working_articles.length + 1
        ad.save_html
      end
    end
  end

end