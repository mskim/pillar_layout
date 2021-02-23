
class PageRubyWorker
  include SuckerPunch::Job

  def perform(path, time_stamp)
    puts "in PageRubyWorker"
    puts "path:#{path}"
    RLayout::NewsPage.new(page_path: path, time_stamp: @time_stamp, jpg: true, config_hash:config_hash)
  end
end
