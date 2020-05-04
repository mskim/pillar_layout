module IssueHtmlLayout
  extend ActiveSupport::Concern

  def front_page_layout_erb(options={})
    layout =<<~EOF

    EOF
  end

  def section_layout_erb(section_name, options={})
    layout =<<~EOF

    EOF
  end

  def article_layout_erb(options={})
    layout =<<~EOF

    EOF
  end

  def save_html
    pages.each do |page|
      page.save_html
    end
  end

end