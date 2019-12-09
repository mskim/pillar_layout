 module WorkingArticleLayout
  extend ActiveSupport::Concern

  attr_accessor :article_layout

  # tokens or text_fragment
  def generate_layout
    h = {}
    h[:article_path] = path
    h[:layout_rb]    = layout_rb
    h[:draft_mode]   = draft_mode
    @article_layout = RLayout::NewsBoxMaker.new(h)
    return self
  end

  def layout_body_lines
    parse_body_paragraphs

  end

  def parse_body_paragraphs

  end


 end