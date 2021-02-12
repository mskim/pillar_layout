module PageAutoAdjust
  extend ActiveSupport::Concern

  def auto_adjust
    result = RLayout::NewsPageAuto.new(page_path: path, time_stamp:true)
    puts "page_path:#{path}"
  end
end