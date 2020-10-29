module StaticIssue
  extend ActiveSupport::Concern

  def static_path
    path + "/build"
  end

  def static_images_path
    static_path + "/images"
  end

  # create build folder
  def build_static_site
    FileUtils.mkdir_p(static_path) unless File.exist?(static_path)
    copy_images_to_static
    create_static_index_page
    create_static_pages
  end

  def copy_images_to_static

  end

  def create_static_index_page
    pages.each do |p|
      p.copy_images_to_static
    end
  end

  def create_static_pages
    FileUtils.mkdir_p(static_images_path) unless File.exist?(static_images_path)
    pages.each do |p|
      p.create_static_page
    end
  end

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