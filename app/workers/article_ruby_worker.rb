require 'rlayout'

class ArticleRubyWorker
  include SuckerPunch::Job

  def perform(path, time_stamp, adjustable_height)
    puts "in ArticleRubyWorker"
    puts "path:#{path}"
    options                       = {}
    options[:article_path]        = path
    options[:jpg]                 = true
    options[:time_stamp]          = time_stamp if time_stamp
    options[:adjustable_height]   = adjustable_height
    RLayout::NewsBoxMaker.new(options)
  end
end