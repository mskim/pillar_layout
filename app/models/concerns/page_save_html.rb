module PageSaveHtml
  extend ActiveSupport::Concern


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