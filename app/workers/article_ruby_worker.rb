# frozen_string_literal: true

# require 'rlayout'

class ArticleRubyWorker
  include SuckerPunch::Job

  def perform(path, options={})
    puts 'in ArticleRubyWorker'
    puts "path:#{path}"
    RLayout::NewsBoxMaker.new(options)
  end
end
