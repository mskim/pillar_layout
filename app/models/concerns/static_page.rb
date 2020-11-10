module StaticPage
  extend ActiveSupport::Concern

  def rjusted_page_number
    page_number.to_s.rjust(4,'0')
  end

  def issue_static_path
    issue.static_path
  end
  
  def static_articles_path
    issue_static_path + "/#{rjusted_page_number}"
  end

  def static_articles_url
    "/#{rjusted_page_number}"
  end
  
  def static_html_path
    issue_static_path + "/#{rjusted_page_number}.html"
  end

  def static_jpg_path
    issue_static_path + "/images/#{rjusted_page_number}.jpg"
  end

  def static_jpg_url
    "images/#{rjusted_page_number}.jpg"
  end

  def static_page_template_path
    "#{Rails.root}/app/views/pages/static_page.html.erb"
  end

  def index_page_link
    rjust = rjusted_page_number
    "<a href= '#{rjust}.html'><img src='images/#{rjust}.jpg' class='border w-100'></a>"
  end

  def static_page_conent
    @prev_page_html = prev_page_html
    @index_html     = index_page_html
    @next_page_html = next_page_html
    @articles       = working_articles.map{|w| w.static_article_links}
    template        = File.open(static_page_template_path, 'r'){|f| f.read}
    erb             = ERB.new(template)
    erb.result(binding)
  end

  def create_static_page
    content = static_page_conent
    File.open(static_html_path, 'w'){|f| f.write content}
    FileUtils.mkdir_p(static_articles_path) unless File.exist?(static_articles_path)
    create_static_articles
  end

  def prev_page_html
    if page_number == 1
      rjust = page_number.to_s.rjust(4,'0')
      "#{rjust}.html"
    else
      rjust = (page_number - 1).to_s.rjust(4,'0')
      "#{rjust}.html"
    end
  end

  def index_page_html
      "index.html"
  end

  def next_page_html
    if page_number == issue.pages.length
      "#{rjusted_page_number}.html"
    else
      rjust = (page_number + 1).to_s.rjust(4,'0')
      "./#{rjust}.html"
    end
  end

  def create_static_articles
    working_articles.each do |w|
      w.create_static_working_article
    end
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


  # sorted all level article, including divide, drop, and overlaps
  def sorted_all_working_articles
    working_articles.sort_by{|w| w.pillar_order}
  end

  def prev_article(article)
    sorted = sorted_all_working_articles
    return article if sorted.first == article
    prev = sorted.first
    sorted.each do |sorted_article|
      return prev if sorted_article == article
      prev = sorted_article
    end
  end

  def next_article(article)
    sorted = sorted_all_working_articles
    return article if sorted.last == article
    sorted.each_with_index do |sorted_article, i|
      return sorted[i + 1] if sorted_article == article
    end
  end

  def first_article
    sorted_all_working_articles.first
  end

  def last_article
    sorted_all_working_articles.last
  end

  def next_page
    issue.pages[page_number]
    if page_number == issue.pages.length
      issue.pages.last
    else
      issue.pages[page_number]
    end
  end

  def prev_page
    if page_number == 1
      issue.pages[0]
    else
      issue.pages[page_number - 2]
    end
  end

  def first_page?
    page_number == 1
  end

  def last_page?
    page_number == issue.pages.length
  end

end