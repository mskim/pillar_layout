require 'rlayout'

class ArticleRubyWorker
  include SuckerPunch::Job

  def perform(path, time_stamp, auto_fit)
    puts "in ArticleWorkerRibu"
    puts "path:#{path}"
    options                 = {}
    options[:article_path]  = path
    options[:jpg]           = true
    options[:time_stamp]    = time_stamp if time_stamp
    options[:auto_fit]      = auto_fit if auto_fit
    RLayout::NewsBoxMaker.new(options)
  end
end