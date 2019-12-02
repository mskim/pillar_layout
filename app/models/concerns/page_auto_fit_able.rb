module PageAutoFitAble
  extend ActiveSupport::Concern
  def auto_fit
    top_position_boxes.each do |top_b|
      top_b.autofit_all_sibllings
    end
  end

  def top_position_boxes
    # TODO what if the top box is image?
    if page_number == 1
      working_articles.select{|w| w.y== 1}
    else
      working_articles.select{|w| w.y== 0}
    end
  end

end