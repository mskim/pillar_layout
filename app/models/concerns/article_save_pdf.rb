
module ArticleSavePdf
  extend ActiveSupport::Concern

  def save_pdf(options={})
    save_hash                = {}
    save_hash[:article_path] = path
    save_hash[:story_md]     = story_md
    save_hash[:layout_rb]    = layout_rb
    RLayout::NewsBoxMaker.new(save_hash)
    if options[:time_stamp]

    end
  end

end