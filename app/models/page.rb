# == Schema Information
#
# Table name: pages
#
#  id                           :integer          not null, primary key
#  page_number                  :integer
#  section_name                 :string
#  column                       :integer
#  row                          :integer
#  ad_type                      :string
#  story_count                  :integer
#  color_page                   :boolean
#  profile                      :string
#  issue_id                     :integer
#  page_plan_id                 :integer
#  template_id                  :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  clone_name                   :string
#  slug                         :string
#  layout                       :text
#  publication_id               :integer
#  path                         :string
#  date                         :date
#  grid_width                   :float
#  grid_height                  :float
#  lines_per_grid               :float
#  width                        :float
#  height                       :float
#  left_margin                  :float
#  top_margin                   :float
#  right_margin                 :float
#  bottom_margin                :float
#  gutter                       :float
#  article_line_thickness       :float
#  page_heading_margin_in_lines :integer
#  tag                          :string
#  display_name                 :string
#
# Indexes
#
#  index_pages_on_issue_id      (issue_id)
#  index_pages_on_page_plan_id  (page_plan_id)
#  index_pages_on_slug          (slug) UNIQUE
#

require 'erb'
require 'net/ftp'


class Page < ApplicationRecord
  # before & after
  # before_create :copy_attributes_from_template
  before_create :init_page_data
  after_create :setup

  # belongs_to
  belongs_to :issue
  belongs_to :page_plan

  # has_one
  has_one :page_heading

  # has_many
  has_many :pillars, :as =>:page_ref
  has_many :working_articles
  has_many :ad_boxes

  # scope
  scope :clone_page, -> {where("clone_name!=?", nil)}
  scope :odd_page, -> {where("clone_name!=?", nil)}
  serialize :layout, Array
  serialize :layout_with_pillar_path, Array
  attr_reader :time_stamp
  include PageSplitable
  include PagePrintable
  include PageSavePdf
  include PageSaveXml
  include StorageBackupPage
  # extend FriendlyId 
  # friendly_id :friendly_string, :use => [:slugged]

  DAYS_IN_KOREAN = %w{일요일 월요일 화요일 수요일 목요일 금요일 토요일 }
  DAYS_IN_ENGLISH = Date::DAYNAMES

  def friendly_string
    "#{date.to_s}_#{page_number}"
  end

  def is_front_page?
    page_number == 1
  end

  def body_line_height
    publication.body_line_height
  end

  def heading_space
    page_heading_margin_in_lines*body_line_height
  end

  def path
    "#{Rails.root}/public/#{publication_id}/issue/#{date.to_s}/#{page_number}"
  end

  def relative_path
    # "/#{publication_id}/issue/#{date.to_s}/#{page_number}"
    #Todo
    "/#{publication_id}/issue/#{date.to_s}/#{page_number}"
  end

  def url
    "/#{publication_id}/issue/#{date.to_s}/#{page_number}"
  end

  def latest_pdf
    f = Dir.glob("#{path}/section*.pdf").sort.last
    File.basename(f) if f
  end

  def latest_pdf_basename
    if @time_stamp
      f = Dir.glob("#{path}/section#{@time_stamp}.pdf")
    else
      f = Dir.glob("#{path}/section*.pdf").sort.last
      File.basename(f) if f
    end
  end

  def latest_jpg_basename
    if @time_stamp
      f = Dir.glob("#{path}/section#{@time_stamp}.jpg")
    else
      f = Dir.glob("#{path}/section*.jpg").sort.last
      File.basename(f) if f
    end
  end

  def pdf_image_path
    # if @time_stamp
    "/#{publication_id}/issue/#{date.to_s}/#{page_number}/#{latest_pdf_basename}"
  end

  def pdf_path
    "#{Rails.root}/public/#{publication_id}/issue/#{date.to_s}/#{page_number}/section.pdf"
  end

  def jpg_image_path
    "/#{publication_id}/issue/#{date.to_s}/#{page_number}/#{latest_jpg_basename}"
  end

  def jpg_path
    "#{Rails.root}/public/#{publication_id}/issue/#{date.to_s}/#{page_number}/section.jpg"
  end

  def to_hash
    p_hash = attributes
    p_hash.delete('created_at')    # delete created_at
    p_hash.delete('updated_at')     # delete updated_at
    p_hash.delete('id')             # delete id
    p_hash
  end

  def siblings(article)
    grid_x          = article.grid_x
    grid_right_edge = article.grid_x + article.column
    grid_bottom     = article.grid_y + article.row
    siblings_array = working_articles.select do |wa|
      wa_right_edge = wa.grid_x + wa.column
      wa.grid_y == grid_bottom && wa.grid_x >= grid_x && wa_right_edge <= grid_right_edge  && wa != article
    end
    # siblings_array += image_boxes.select do |image_box|
    #   image_box.grid_y == grid_bottom && wa.grid_x >= grid_x && wa != article
    # end
  end

  def bottom_article?(article)
    article_bottom_grid     = article.grid_y + article.row
    article_x_grid          = article.grid_x
    article_y_grid          = article.grid_y
    return true if article_bottom_grid == row
    ad_box = ad_boxes.first
    return false if ad_box.nil?
    ad_box_x_max_grid       = ad_box.grid_x + ad_box.column
    if ad_box.grid_y == article_bottom_grid && ad_box.grid_x <= article_x_grid && article_x_grid <= ad_box_x_max_grid
      return true
    end
    false
  end

  def clone
    h = to_hash

    h[:clone_name] = 'b'
    unless b = Page.where(h).first
      Page.create!(h)
      return
    end
    h[:clone_name] = 'c'
    unless c = Page.where(h).first
      Page.create!(h)
      return
    end
    h[:clone_name] = 'd'
    unless c = Page.where(h).first
      Page.create!(h)
      return
    end
  end

  def publication
    issue.publication
  end

  def page_heading_path
    path + "/heading"
  end

  def page_heading_url
    url + "/heading"
  end

  def page_headig_layout_path
    page_heading_path + "/layout.rb"
  end

  def doc_width
    publication.width
    # width + left_margin + right_margin
  end

  def page_width
    publication.page_width
    # width
  end

  def doc_height
    publication.height
    # height + top_margin + bottom_margin
  end

  def doc_left_margin
    publication.left_margin
    # left_margin
  end

  def doc_top_margin
    publication.top_margin
    # top_margin
  end

  def page_height
    publication.page_height

    # height
  end

  def page_heading_width
    # width
    publication.page_heading_width
  end

  def issue_week_day_in_korean
    DAYS_IN_KOREAN[date.wday]
  end

  def year
    date.year
  end

  def month
    date.month
  end

  def day
    date.day
  end

  def date
    issue.date
  end

  def korean_date_string
    if page_number == 1
      "#{date.year}년 #{date.month}월 #{date.day}일 #{issue_week_day_in_korean} (#{issue.number}호)"
    else
      "#{date.year}년 #{date.month}월 #{date.day}일 #{issue_week_day_in_korean}"
    end
  end

  def self.update_page_headings
    Page.all.each do |page|
      PageHeading.generate_pdf(page)
    end
  end

  def sample_ad_folder
    "#{Rails.root}/public/#{publication_id}/ad"
  end

  def issue_ads_folder
    "#{Rails.root}/public/#{publication_id}/issue/#{date.to_s}/ads"
  end

  def ad_image_string
    ad = ad_images.first
    if ad
      return ad_images.first.ad_image_string
    end
    ""
  end

  def save_issue_plan_ad
    if ad_type && ad_type != ""
      issue_ad_string = "#{page_number}_#{ad_type}"
      system "cd #{issue_ads_folder} && touch #{issue_ad_string}"
    end
  end

  def select_sample_ad
    Dir.glob("#{sample_ad_folder}/#{column}#{ad_type}/*{.jpg,.pdf}").sample
  end

  def copy_sample_ad
    if ad_type && ad_type != ""
      sample = select_sample_ad
      basename = File.basename(sample)
      ad_name  = "#{page_number}_#{basename}"
      system "cp #{sample} #{issue_ads_folder}/ad_name"
    end
  end
  
  def template_page_number
    template_path = "#{Rails.root}/public/1/section/#{page_number}" 
    if File.exist?(template_path)
      number = page_number
    elsif page_number.even?
      number = 100
    else
      number = 101
    end
    number
  end

  def section_template_folder
    s = "#{Rails.root}/public/#{publication_id}/section/#{template_page_number}/#{profile}/#{template_id}"
    if File.exist?(s)
      s
    else
      if page_number.odd?
        template_page_number = 101
      else 
        template_page_number = 100
      end
      "#{Rails.root}/public/#{publication_id}/section/#{template_page_number}/#{profile}/#{template_id}"
    end
  end

  def change_ad_boxes(section)
    # assuming only one ad per page,  
    # TODO handle case when there are multiple ads in a page
    # section.ad_box_templates.each_with_index do |ad_box_template, i|
    ad_box_template = section.ad_box_templates.first
    if ad_box_template
      current = {page_id: self.id, ad_type: self.ad_type}
      if ad = AdBox.where(current).first
        puts  "same type found, do nothing"
      else
        current            = {}
        current['page_id'] = id
        current['ad_type'] = ad_box_template.ad_type
        current['grid_x']  = ad_box_template.grid_x
        current['grid_y']  = ad_box_template.grid_y
        current['column']  = ad_box_template.column
        current['row']     = ad_box_template.row
        current['order']   = 1

        if ad_boxes.length > 0
          puts "different type of ad exists: #{ad_box_template.ad_type}, change it to new ad type :#{current[:ad_type]}"
          currnet_ad_box = ad_boxes.first
          currnet_ad_box.update(current)
          currnet_ad_box.save
          currnet_ad_box.generate_pdf_with_time_stamp
        else
          a = AdBox.create(current)
          a.generate_pdf_with_time_stamp
        end
      end
    else
      # delete ad_boxwa, if new section has no ad_box
      ad_boxes.each do |ab|
        ab.destroy
      end
    end
  end

  def story_backup_folder
    path + "/story_backup"
  end

  def backup_stories(story_number)
    #code
  end

  def config_path
    path + "/config.yml"
  end

  def config_hash
    h = {}
    h['section_name']                   = section_name
    h['page_heading_margin_in_lines']   = page_heading_margin_in_lines
    h['ad_type']                        = ad_type || "no_ad"
    h['is_front_page']                  = is_front_page?
    # h['profile']                        = profile
    # h['section_id']                     = id
    h['page_columns']                   = column
    h['grid_size']                      = [grid_width, grid_height]
    h['lines_per_grid']                 = lines_per_grid
    h['width']                          = width
    h['height']                         = height
    h['left_margin']                    = left_margin
    h['top_margin']                     = top_margin
    h['right_margin']                   = right_margin
    h['bottom_margin']                  = bottom_margin
    h['gutter']                         = gutter
    h['story_frames']                   = layout
    h['article_line_thickness']         = article_line_thickness
    h['draw_divider']                   = true if page_number != 22 || page_number != 23
    h
  end

  def update_working_article_layout
    layout = []
    working_articles.each do |wa|
      layout << wa.layout_info
    end
    self.layout = layout.to_s
    self.save
  end

  def  update_config_file_to_draw_divider
    h = config_hash
    h['draw_divider'] = true
    File.open(config_yml_path, 'w'){|f| f.write h.to_yaml}
  end

  def  update_config_file_not_to_draw_divider
    h = config_hash
    h['draw_divider'] = false
    File.open(config_yml_path, 'w'){|f| f.write h.to_yaml}
  end

  def update_config_file
    h = config_hash
    h['layout'] = update_working_article_layout
    yaml = h.to_yaml
    File.open(config_yml_path, 'w'){|f| f.write yaml}
  end

  def config_yml_path
    path + "/config.yml"
  end

  def save_config_file
    system "mkdir -p #{path}" unless File.directory?(path)
    yaml = config_hash.to_yaml
    File.open(config_yml_path, 'w'){|f| f.write yaml}
  end

  def copy_config_file
    source = section_template_folder + "/config.yml"
    config_hash = YAML::load_file(source)
    config_hash['date'] = date.to_s
    target = path + "/config.yml"
    File.open(target, 'w'){|f| f.write(config_hash.to_yaml)}
  end

  def copy_section_pdf
    source = section_template_folder + "/section.pdf"
    target = path + "/section.pdf"
    system "cp #{source} #{target}"
    jpg_source = section_template_folder + "/section.jpg"
    jpg_target = path + "/section.jpg"
    system "cp #{jpg_source} #{jpg_target}"
  end

  def put_space_between_chars(string)
    s = ""
    i = 0
    length = string.length
    string.each_char do |ch|
      if i >= length - 1
        s += ch
      elsif ch == " "
        s += ch
      else
        s += ch + " "
      end
      i += 1
    end
    s
  end

  def heading_page_number
    page_heading_path = "#{Rails.root}/public/1/page_heading/#{page_number}" 
    if File.exist?(page_heading_path)
      number = page_number
    elsif page_number.even?
      number = 100
    else
      number = 101
    end
    number
  end

  def copy_heading
    FileUtils.mkdir_p(page_heading_path) unless File.exist?(page_heading_path)
    source = issue.publication.heading_path + "/#{heading_page_number}"
    target = page_heading_path
    layout_erb_path     = page_heading_path + "/layout.erb"
    system "cp -R #{source}/ #{target}/"
    layout_erb_content  = File.open(layout_erb_path, 'r'){|f| f.read}
    erb                 = ERB.new(layout_erb_content)
    @date               = korean_date_string
    @section_name       = put_space_between_chars(section_name)
    @page_number        = page_number
    layout_content      = erb.result(binding)
    layout_rb_path      = page_heading_path + "/layout.rb"
    File.open(layout_rb_path, 'w'){|f| f.write layout_content}
    system "cd #{page_heading_path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end

  def copy_section_template(section)
    
    old_article_count = working_articles.length
    new_aricle_count  = section.story_count
    copy_config_file
    copy_section_pdf
    new_aricle_count.times do |i|
      source = section.path + "/#{i + 1}"
      article_folder = path + "/#{i + 1}"
      # if artile folder is empty, copy the whole article template folder
      unless File.exist?(article_folder)
        FileUtils.mkdir_p article_folder
        system("cp -r #{source}/ #{article_folder}/")
      # if there are current article, copy layout.rb from article template
      else
        layout_template = source + "/layout.rb"
        system("cp  #{layout_template} #{article_folder}/")
      end
    end
    copy_ad_folder(section)
    copy_heading
  end

  def copy_ad_folder(section)
    ad_folder = section.path + "/ad"
    system("cp  -r #{ad_folder} #{path}") if File.exist? ad_folder
  end

  def create_heading
    heading_atts                  = {}
    heading_atts[:page_number]    = page_number
    heading_atts[:section_name]   = display_name || section_name
    heading_atts[:page_id]        = self.id
    heading_atts[:date]           = date
    result                        = PageHeading.where(heading_atts).first_or_create
  end

  def change_heading
    section  = Section.find(template_id)
    FileUtils.mkdir_p(page_heading_path) unless File.exist?(page_heading_path)
    source = section.page_heading_path
    target = page_heading_path
    layout_erb_path     = page_heading_path + "/layout.erb"
    # unless File.exist? layout_erb_path
    system "cp -R #{source}/ #{target}/"
    # end
    layout_erb_content  = File.open(layout_erb_path, 'r'){|f| f.read}
    erb                 = ERB.new(layout_erb_content)
    @date               = korean_date_string
    # @section_name       = section_name
    @section_name       = put_space_between_chars(section_name)
    @page_number        = page_number
    layout_content      = erb.result(binding)
    layout_rb_path      = page_heading_path + "/layout.rb"
    File.open(layout_rb_path, 'w'){|f| f.write layout_content}
    system "cd #{page_heading_path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end

  def save_as_default
    default_issue_plan_path = issue.default_issue_plan_path
    issue_hash = eval(File.open(default_issue_plan_path, 'r'){|f| f.read})
    issue_hash[page_number - 1] << template_id
    File.open(default_issue_plan_path, 'w'){|f| f.write issue_hash.to_s}
  end

  def generate_heading_pdf
    page_heading.generate_pdf
  end

  def stamp_time
    t = Time.now
    h = t.hour
    @time_stamp = "#{t.day.to_s.rjust(2,'0')}#{t.hour.to_s.rjust(2,'0')}#{t.min.to_s.rjust(2,'0')}#{t.sec.to_s.rjust(2,'0')}"
  end

  def stamped_pdf_file
    path + "/section#{@time_stamp}.pdf"
  end

  def wait_for_stamped_pdf
    starting = Time.now
    times_up = starting + 60*1
    while !File.exist?(stamped_pdf_file)
      sleep(1)
      if Time.now > times_up
        puts "Waited for 5 seconds!!! Time is up brake"
        break
      end
    end
  end

  def delete_old_files
    old_pdf_files = Dir.glob("#{path}/section*.pdf")
    old_jpg_files = Dir.glob("#{path}/section*.jpg")
    old_pdf_files += old_jpg_files
    # pdf_file_to_delete = Dir.glob("#{path}/section*.pdf")
    # jpg_file_to_delete = pdf_file_to_delete.map{|f| f.sub(/pdf$/, "jpg")}
    old_pdf_files.each do |old|
      system("rm #{old}")
    end
  end

  def generate_pdf_with_time_stamp
    puts "in page generate_pdf_with_time_stamp"
    delete_old_files
    stamp_time
    save_pdf(time_stamp:@time_stamp)
    # PageWorker.perform_async(path, @time_stamp)
    # wait_for_stamped_pdf
    # system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman section . -time_stamp=#{@time_stamp}"
  end

  def generate_pdf
    puts "generate_pdf for page"
    # PageWorker.perform_async(path, nil)
    save_pdf
  end

  def regenerate_pdf
    generate_heading_pdf
    working_articles.each do |working_article|
      working_article.generate_pdf
    end
    ad_boxes.each do |ad_box|
      ad_box.generate_pdf
    end
    PageWorker.perform_async(path, nil)
  end

  def site_path
    File.expand_path("~/Sites/naeil/#{date.to_s}/#{page_number}")
  end

  def copy_outputs_to_site
    FileUtils.mkdir_p site_path unless File.exist?(site_path)
    system "cp #{pdf_path} #{site_path}/"
    system "cp #{jpg_path} #{site_path}/"
  end

  # other SectionTemplate choices for current page
  def other_choices
    Section.where(page_number: page_number).all
  end

  def page_heading_jpg_path
    page_heading_url + "/output.jpg"
  end

  def page_heading_pdf_path
    page_heading_url + "/output.pdf"
  end

  def page_svg
    "<image xlink:href='#{pdf_image_path}' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />\n"
  end

  def box_svg
    box_element_svg = page_svg
    box_element_svg += "<g transform='translate(#{doc_left_margin},#{doc_top_margin})' >\n"
    # box_element_svg += page_svg
    box_element_svg += page_heading.box_svg if page_number == 1
    working_articles.each do |article|
      next if article.inactive
      box_element_svg += article.box_svg
    end
    if ad_box = ad_boxes.first
      box_element_svg += ad_box.box_svg
    end
    box_element_svg += '</g>'
    box_element_svg
  end

  def to_svg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{doc_width} #{doc_height}' >
      <rect fill='white' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />
      #{box_svg}
    </svg>
    EOF
  end

  def story_svg
    box_element_svg = page_svg_with_jpg
    box_element_svg += "<g transform='translate(#{doc_left_margin},#{doc_top_margin})' >\n"
    # box_element_svg += page_svg
    box_element_svg += page_heading.box_svg if page_number == 1
    working_articles.each do |article|
      next if article.inactive
      box_element_svg += article.story_svg
    end
    if ad_box = ad_boxes.first
      box_element_svg += ad_box.box_svg
    end
    box_element_svg += '</g>'
    box_element_svg
  end

  def to_svg_with_jpg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{doc_width} #{doc_height}' >
      <rect fill='white' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />
      #{box_svg_with_jpg}
    </svg>
    EOF
  end

  def to_svg_test
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{doc_width} #{doc_height}' >
      <rect fill='white' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />
      #{page_svg_with_jpg}
    </svg>
    EOF
  end

  def page_svg_with_jpg
    "<image xlink:href='#{pdf_image_path}' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />\n"
  end

  def box_svg_with_jpg
    box_element_svg = page_svg_with_jpg
    box_element_svg += "<g transform='translate(#{doc_left_margin},#{doc_top_margin})' >\n"
    box_element_svg += page_heading.box_svg if page_number == 1
    # working_articles.each do |article|
    #   box_element_svg += article.box_svg
    # end
    pillars.each do |pillar|
      box_element_svg += pillar.box_svg_with_jpg
    end
    ad_boxes.each do |ad_box|
      box_element_svg += ad_box.box_svg
    end
    box_element_svg += '</g>'
    box_element_svg
  end

  def svg_path
    path + "/page.svg"
  end

  def save_svg
    File.open(svg_path, 'w'){|f| f.write to_svg_with_jpg}
  end

  def to_story_svg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{doc_width} #{doc_height}' >
      <rect fill='white' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />
      #{story_svg}
    </svg>
    EOF
  end

  def section_pages
    issue.pages.select{|p| p.section_name == section_name}
  end

  def page_template_folder
    "#{Rails.root}/public/1/page_template"
  end

  def page_template_path
    "#{page_template_folder}/#{issue.date_string}_#{page_number}.yml"
  end

  def page_info_hash
    tempalate = {}
    tempalate[:section_name]  = section_name
    tempalate[:column]        = column
    tempalate[:row]           = row
    tempalate[:ad_type]       = ad_type
    tempalate[:layout]        = []
    working_articles.each do |wa|
      tempalate[:layout] << wa.layout_info
    end
    tempalate
  end

  def save_as_template
    s = Section.create(page_info_hash)
    puts "s.id:#{s.id}"
    # FileUtils.mkdir_p(page_template_folder) unless File.exist?(page_template_folder)
    # File.open(page_template_path, 'w'){|f| f.write page_info_yml}
    s.id
  end

  def download_path
    path + "_download"
  end

  def prepare_for_download
    copy_page_folder_for_download
    copy_working_article_images_for_download
    copy_ad_image_for_download
  end

  def copy_page_folder_for_download

  end

  def copy_working_article_images_for_download
    # heading_image
    # article images, graphics

  end

  def copy_ad_image_for_download

  end

  def zipfile_path
    "#{path}.zip"
  end

  def zip_page
    # zip page folder for download
    input_filenames = Dir.glob("#{path}/**/*")
    FileUtils.rm_rf("#{zipfile_path}") if File.exist?(zipfile_path)
    # zip a folder with files and subfolders
    Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
      Dir["#{path}/**/**"].each do |file|
        # Two arguments:
        # – The name of the file as it will appear in the archive
        # – The original file, including the path to find it
        zipfile.add(file.sub(path + '/', ''), file)
      end
      # zipfile.get_output_stream("success") { |os| os.write "All done successfully" }
    end

  end

  def copy_from_sample
    source = "#{Rails.root}/public/1/issue_sample/#{page_number}"
    if File.exist?(pdf_path)
    elsif File.exist?(source)
      system("cp -r #{source} #{path}/")
    end
  end

  def setup
    system "mkdir -p #{path}" unless File.exist?(path)
    # copy_section_template(section)
    create_heading
    create_pillars
    # create_ad_boxes(section)
    copy_from_sample
    save_config_file unless File.exist?(config_path)
    generate_pdf unless File.exist?(pdf_path)
  end

  def create_pillars
    layout.each_with_index do |item, i|
      if item.first.class == String
        self.ad_type = item
        self.save
        create_ad_box(item)
      # elsif item.first.class == Array
      #   create_pillar_layout_node(item, i + 1)
      # elsif item.first[4].class == Hash
      #   create_layout_node_with_overlap(layout:item)
      elsif item.length == 5
        Pillar.where(page_ref: self, grid_x: item[0], grid_y: item[1], column: item[2], row: item[3], order: i + 1, box_count:item[4]).first_or_create
      elsif item.length == 4
        Pillar.where(page_ref: self, grid_x: item[0], grid_y: item[1], column: item[2], row: item[3], order: i + 1, box_count:1).first_or_create
      end
    end
  end

  # def delete_pillars
  #   pillars.each do |pil|
  #     pil.destroy
  #   end
  #   system("rm -rf #{path}")
  # end

  # TODO
  def change_page_layout(new_layout_id)
    update(template_id:new_layout_id)
    new_page_layout = PageLayout.find(new_layout_id.to_i)

    if pillars.length == new_page_layout.pillars.length
      # New page layout and current one has equal number of pillars
      pillars.each_with_index do |p, i|
        #TODO Pillar should have layout_with_pillar_path
        layout_with_pillar_path = new_page_layout.pillars[i].layout_with_pillar_path
        if layout_with_pillar_path == []
          profile = new_page_layout.pillars[i].profile
          layout_with_pillar_path = LayoutNode.where(profile: profile).first.leaf_node_layout_with_pillar_path
          p.change_layout(layout_with_pillar_path)
        else
          p.change_layout(layout_with_pillar_path)
        end
      end
    elsif pillars.length > new_page_layout.pillars.length
      # Current layout has more number of pillars
      pillars.each_with_index do |p, i|
        if i >= new_page_layout.pillars.length
          # delete pillar
          p.destory
        else
          layout_with_pillar_path = new_page_layout.pillars[i].layout_with_pillar_path
          # TODO Pillar should have layout_with_pillar_path
          # somehow we seem to be not doing this. fix this we don't need to do the following
          if layout_with_pillar_path == []
            profile = new_page_layout.pillars[i].profile
            layout_with_pillar_path = LayoutNode.where(profile: profile).first.leaf_node_layout_with_pillar_path
            p.change_layout(layout_with_pillar_path)
          else
            p.change_layout(layout_with_pillar_path)
          end
        end
      end
    else
      # New page layout has more pillars than currnt one
      new_page_layout.layout.each_with_index do |layout, i|
        if i >= news_layout.length
          # create new pillar
          Pillar.where(page_ref: self, grid_x: layout[0], grid_y: layout[1], column: layout[2], row: layout[3], order: i + 1, box_count:layout[4]).first_or_create
        else
          layout_with_pillar_path = new_page_layout.pillars[i].layout_with_pillar_path
          if layout_with_pillar_path == []
            profile = new_page_layout.pillars[i].profile
            layout_with_pillar_path = LayoutNode.where(profile: profile).layout_with_pillar_path
            p = pillars[i]
            p.change_layout(layout_with_pillar_path)
          else
            p.change_layout(layout_with_pillar_path)
          end
        end
      end
    end
    # change_ad_box
    if ad_type != new_page_layout.ad_type && ad_type != "광고없음"
      @ad_boxes.first.change_layout(new_page_layout.ad_type)
    end
  end

  # other SectionTemplate choices for current page
  def other_page_layout_choices
    choices = []
    if page_number == 1
      choices =PageLayout.where(ad_type: ad_type, page_type: 1).all
    else
      choices += PageLayout.where(ad_type: ad_type, page_type:page_number).all
      if page_number.odd?
        choices += PageLayout.where(ad_type: ad_type, page_type:101).all
      else
        choices += PageLayout.where(ad_type: ad_type, page_type:100).all
      end
    end
    # also select page specified template 
    # choices += PageLayout.where(ad_type: ad_type, page_type: page_number).all
    choices
  end

  def create_ad_box(ad_type)
    info = {page_id: self.id, order:1}
    case ad_type
    when '15단통'
      info[:grid_x] = 0
      info[:grid_y] = 0
      info[:column] = column
      info[:row]    = 15
    when '5단통'
      info[:grid_x] = 0
      info[:grid_y] = 10
      info[:column] = column
      info[:row]    = 5
    when '4단통'
      info[:grid_x] = 0
      info[:grid_y] = 11
      info[:column] = column
      info[:row]    = 4
    when '3단통'
      info[:grid_x] = 0
      info[:grid_y] = 12
      info[:column] = column
      info[:row]    = 3
    when '9단21'
      if page_number.odd?
        info[:grid_x] = 3
        info[:grid_y] = 6
        info[:column] = 4
        info[:row]    = 9
      else
        info[:grid_x] = 0
        info[:grid_y] = 6
        info[:column] = 4
        info[:row]    = 9
      end
    when '9단21_홀'
      info[:grid_x] = 3
      info[:grid_y] = 6
      info[:column] = 4
      info[:row]    = 9
    when '9단21_짝'
      info[:grid_x] = 0
      info[:grid_y] = 6
      info[:column] = 4
      info[:row]    = 9
    when '7단15'
      if page_number.odd?
        info[:grid_x] = 0
        info[:grid_y] = 8
        info[:column] = 3
        info[:row]    = 7
      else
        info[:grid_x] = 4
        info[:grid_y] = 8
        info[:column] = 3
        info[:row]    = 7
      end
    when '7단15_홀'
      info[:grid_x] = 0
      info[:grid_y] = 8
      info[:column] = 3
      info[:row]    = 7
    when '7단15_짝'
      info[:grid_x] = 4
      info[:grid_y] = 8
      info[:column] = 3
      info[:row]    = 7
    else
      puts "+++++++++ unsupported ad_type:#{ad_type}"
      return
    end
    AdBox.create(info)
  end

  def position_list
    positions = []
    pillars.sort_by{|p| p.order}.each do |p|
      positions += p.working_articles.map{|w| w.pillar_order}
    end
    positions
  end

  private

  def copy_attributes_from_template
    section         = Section.find(template_id)
    self.publication_id = issue.publication.id
    self.date         = issue.date
    self.profile      = section.profile
    self.column       = section.column
    self.row          = section.row
    self.ad_type      = section.ad_type
    self.story_count  = section.story_count
    self.grid_width   = section.grid_width
    self.grid_height  = section.grid_height
    self.lines_per_grid = section.lines_per_grid
    self.width        = section.width
    self.height       = section.height
    self.left_margin  = section.left_margin
    self.top_margin   = section.top_margin
    self.right_margin = section.right_margin
    self.bottom_margin = section.bottom_margin
    self.gutter       = section.gutter
    self.article_line_thickness = section.article_line_thickness 
    self.layout       = section.layout
    self.page_heading_margin_in_lines = section.page_heading_margin_in_lines
    if clone_name == nil
      self.path = "#{Rails.root}/public/#{self.publication_id}/issue/#{self.date.to_s}/#{page_number}"
    else
      self.path = "#{Rails.root}/public/#{self.publication_id}/issue/#{self.date.to_s}/#{page_number}-#{clone_name}"
    end
    true
  end

  # 
  def init_page_data
    publication               = issue.publication
    self.publication_id       = publication.id
    self.date                 = issue.date
    template                  = PageLayout.find(template_id)      # case when page_template is given
    self.layout               = template.layout
    # else
    #   # case when no info is given, we start with typical setup
    #   if column == 6
    #     self.layout = [[0,0,4,10,2], [4,0,2,10,3], '5단통']
    #   else
    #     self.layout = [[0,0,5,10,2], [5,0,2,10,3], '5단통']
    #   end
    # end
    self.publication_id         = issue.publication.id
    # self.profile              = section.profile
    # self.page_number          = section.page_number
    # self.section_name         = section.section_name
    self.column                 = template.column
    self.ad_type                = template.ad_type
    self.story_count            = template.story_count
    self.lines_per_grid         = 7
    self.article_line_thickness = publication.article_line_thickness 
    self.page_heading_margin_in_lines = publication.page_heading_margin_in_lines(page_number)
    self.row                    = 15
    self.grid_width             = publication.grid_width(column)
    self.grid_height            = publication.grid_height
    self.lines_per_grid         = publication.lines_per_grid
    self.width                  = publication.width
    self.height                 = publication.height
    self.left_margin            = publication.left_margin
    self.top_margin             = publication.top_margin
    self.right_margin           = publication.right_margin
    self.bottom_margin          = publication.bottom_margin
    self.gutter                 = publication.gutter
    self.article_line_thickness = publication.article_line_thickness
    self.publication_id         = publication.id
  end

  def init_page
    save_config_file
    create_pillars
    true
  end


end
