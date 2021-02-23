module PageAutoAdjust
  extend ActiveSupport::Concern

  def auto_adjust
    result = RLayout::NewsPage.new(page_path: path, time_stamp:true)
    puts "page_path:#{path}"
  end
end