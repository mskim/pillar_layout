module ArticleSaveHtml
  extend ActiveSupport::Concern

  def html_path
    issue.path + "/#{html}/#{date_section_order}"
  end

  def date_section_order
    "#{issue.date_string}_#{page.section}_#{pillar_order}"
  end

  # convert # ## ### #### to conventioanal markup 
  # # => ###
  # ## => ####
  # ### => ####
  def convert_story_to_conventional_md 
    ""
  end

  def md2html
    ""
  end

  def to_html
    md = convert_story_to_conventional_md
    content = md2html(md)

  end

  def save_html
    File.open(html_path, 'w'){|f| f.write to_html}
  end
end