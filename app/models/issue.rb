# frozen_string_literal: true

# == Schema Information
#
# Table name: issues
#
#  id             :integer          not null, primary key
#  date           :date
#  excel_file     :string
#  number         :string
#  page_count     :integer
#  plan           :text
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :integer
#
# Indexes
#
#  index_issues_on_publication_id  (publication_id)
#  index_issues_on_slug            (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

require 'zip/zip'

class Issue < ApplicationRecord
  # before & after
  before_create :read_issue_plan
  after_create :setup

  # belongs_to
  belongs_to :publication

  # has_one
  has_one :spread, dependent: :delete

  # has_many
  has_many  :page_plans, dependent: :delete_all
  has_many  :pages, -> { order(page_number: :asc) }, dependent: :delete_all
  has_many :working_articles, through: :pages
  has_many :images
  has_many :ad_images

  # accepts_nested_attributes_for
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :ad_images

  # validates
  validates_presence_of :date
  validates_uniqueness_of :date

  # carrierwave
  mount_uploader :excel_file, ExcelFileUploader

  include IssueStoryMakeable
  include IssueGithubWorkflow
  include IssueSaveXml
  include StaticIssue
  include GithubIssue
  # def save_to_web_article
  #   working_articles.each(&:save_to_story)
  # end

  def reporter_from_body
    body.match(/^# (.*)/) if body && body != ''
    Regexp.last_match(1).to_s.sub('# ', '')
  end

  def publication_path
    publication.path
  end

  def path
    publication_path + "/issue/#{date}"
  end

  def page_with_page_number(page_number)
    pages.select{|p| p.page_number == page_number}.first
  end

  def relative_path
    "#{publication_id}/issue/#{date}"
  end

  def default_issue_plan_path
    "#{Rails.root}/public/#{publication_id}/default_issue_plan.rb"
  end

  def set_color_page
    pages.each do |page|
      # puts page.page_number
      if page.page_number == 22 || page.page_number == 23 || page.page_number == 10
        page.color_page = false
      else
        page.color_page = true
      end
      page.save
    end
  end

  # this is used in issue_plan for selecting available ad_types for given page
  # array of arrays of ad_types
  def available_ads_for_pages
    page_ads = []
    24.times do |index|
      page_ads << available_ads_for(index + 1)
    end
    page_ads
  end

  def available_ads_for(page_number)
    ad_type_array = []
    ad_type_array << PageLayout.where(page_type: page_number.to_s).all.map(&:ad_type)
    if page_number == 1
    elsif page_number.odd?
      ad_type_array << PageLayout.where(page_type: '101').all.map(&:ad_type)
    else
      ad_type_array << PageLayout.where(page_type: '100').all.map(&:ad_type)
    end
    if page_number == 12
      ad_type_array += %w[5단_브릿지 7단_브릿지 8단_브릿지 9단_브릿지 10단_브릿지 15단_브릿지]
    end
    ad_type_array.flatten.uniq.sort
  end

  def setup
    system "mkdir -p #{path}" unless File.directory?(path)
    # copy_from_sample
    unless File.directory?(issue_images_path)
      system "mkdir -p #{issue_images_path}"
    end
    system "mkdir -p #{issue_ads_path}" unless File.directory?(issue_ads_path)
  end

  def sample_path
    "#{Rails.root}/public/1/sample/issue"
  end

  # def copy_from_sample
  #   system("cp -r #{sample_path}/ #{path}/")
  # end

  DAYS_IN_KOREAN = %w[(일) (월) (화) (수) (목) (금) (토)].freeze

  def issue_week_day_in_korean
    DAYS_IN_KOREAN[date.wday]
  end

  def date_string
    date.strftime('%Y%m%d')
  end

  def korean_date_string
    # "#{date.year}년 #{date.month}월 #{date.day}일 #{issue_week_day_in_korean} (#{number}호)"
    "#{date.month}월 #{date.day}일 #{issue_week_day_in_korean} #{number}호"
  end

  # def section_path
  #   "#{Rails.root}/public/#{publication_id}/section"
  # end

  def eval_issue_plan
    eval(plan)
    # YAML::load(plan)
  end

  def issue_images_path
    path + '/images'
  end

  def issue_ads_path
    path + '/ads'
  end

  def issue_ad_list_path
    path + '/ads/ad_list.yml'
  end

  def issue_info_for_cms
    {
      'id' => id,
      'date' => date.to_s,
      'plan' => plan
    }
  end

  def current_working_articles_hash
    # code
  end

  def request_cms_new_issue
    puts __method__
    # cms_address = 'http://localhost:3001'
    # puts "#{cms_address}/#{id}"
    # RestClient.post( "#{cms_address}/api/v1/cms_new_issue/#{id}", {'payload' => issue_info_for_cms})
  end

  def news_cms_host
    'http://localhost:3001'
  end

  def news_cms_head
    "#{news_cms_host}/update_issue_plan"
  end

  def make_default_issue_plan
    # check if we have uploaded Excel file
    # section_names_array = eval(publication.section_names)
    if File.exist?(excel_file_path)
      excel_info    = parse_excel_file
      issue_info    = excel_info[:issue_info]
      default_plans = excel_info[:issue_plan]
      default_plans.each_with_index do |page_array, i|
        page_hash = {}
        page_hash[:issue_id]     = id
        page_hash[:dead_line]    = page_array[0]
        page_hash[:page_number]  = i + 1
        page_hash[:section_name] = page_array[2]
        # TODO parse ad_data into know values
        if page_array[3]
          ad_info_array           = page_array[3].split(" ")
          ad_type                 = ad_info_array[0]
          advertiser              = ad_info_array[1]
          page_hash[:ad_type]     = ad_type
          page_hash[:advertiser]  = advertiser
        elsif page_array[3].nil? || page_array[3] == '광고없음'
          page_hash[:ad_type] = '광고없음'
        end

        if page_array[4] == '컬러' || page_array[4] == '칼러' || page_array[4] == '칼라'
          page_hash[:color_page]   = true 
        else
          page_hash[:color_page]   = false 
        end
        p = PagePlan.where(page_hash).first_or_create!
      end
    else
      default_plans = eval(plan)
      default_plans.each_with_index do |page_array, i|
        page_hash = {}
        page_hash[:issue_id] = id
        # puts "page_hash[:section_name]:#{page_hash[:section_name]}"
        page_hash[:page_number]  = i + 1
        page_hash[:section_name] = page_array[0]
        page_hash[:ad_type]      = page_array[1]
        page_hash[:color_page]   = page_array[2] if page_array.length > 2
        p = PagePlan.where(page_hash).first_or_create!
      end
    end

  end


  def excel_file_path
    path + "/excel/issue_plan.xlsx"
  end

  # first row us the issue_info row
  # second row is empty
  # third row is headings
  # first 4 cell are front and next 4 cell are paired back page 
  # body row are made up with 2 rows, first cell if second row has color information
  def parse_excel_file
    front_half  = [] # 1..12
    back_half   = [] # 24..13
    first_half  = [] # 0,1,2,3  1,2,3,4
    second_half = [] # 4,5,6,7  24,23,22,21
    half_position = 4
    workbook = RubyXL::Parser.parse(excel_file_path)
    worksheet = workbook[0]
    worksheet.each_with_index do |row, i|
      if i == 0
        @issue_info = row[0].value
        next
      elsif i == 1
        # this is blank lind
        next
      elsif i == 2
        next
        # this is haading row
      else
        row.cells.each_with_index do |cell, j|
          if j < half_position
            if cell.value.class == DateTime
              first_half << "#{cell.value.hour}:#{cell.value.min}"
            else
              first_half << cell.value
            end
          else
            if cell.value.class == DateTime
              second_half << "#{cell.value.hour}:#{cell.value.min}"
            else
              second_half << cell.value
            end
          end
        end
        front_half  << first_half
        back_half   << second_half
        first_half = []
        second_half = []
      end
    end
    merged_front  = merge_front_rows(front_half)
    merged_back   = merge_back_rows(back_half)
    issue_plan    = merged_front + merged_back
    info = {issue_info: @issue_info, issue_plan: issue_plan}
  end

  # merge 1..12
  # second row has color information
  def merge_front_rows(front_half)
    result = []
    front = []
    front_half.each_with_index do |row, i|
      if i.even?
        front = row
      else
        front << row[0]
        result << front
      end
    end
    result
  end

  # merge 24..13 
  # first reverse the array and and color infor to following row
  # unlike merge_front_rows, first row has color information
  def merge_back_rows(back_half)
    result  = []
    front   = []
    current_color = nil?
    back_half.reverse.each_with_index do |row, i|
      if i.even?
        current_color = row[0]
      else
        front = row
        front << current_color
        result << front
      end
    end
    result
  end


  def update_plan
    make_pages
    # parse_images
    # parse_ad_images
    # parse_graphics
  end

  def make_spread
    puts 'in make_spread'
    Spread.create!(issue_id: id)
  end

  def make_pages
    page_plans.sort_by(&:page_number).each_with_index do |page_plan, i|
      if page_plan.page
        if page_plan.need_update?
          if page_plan.page.color_page != page_plan.color_page
            page_plan.page.color_page = page_plan.color_page
            page_plan.page.save
          end
          page_plan.page.change_template(page_plan.selected_template_id)
          page_plan.dirty = false
          page_plan.save
        end
        next
      else
        page_number = i + 1
        ad_type = page_plan.ad_type.unicode_normalize
        # first look for default in page_library folder if libray exist?
        page_library_root_path      = "#{Rails.root}/public/#{publication.id}/page_library"
        default_page_library_foder  = page_library_root_path + "/default/#{page_number}/#{ad_type}"
        if File.exist?(default_page_library_foder)
          # load page_library
          h = {}
          h[:issue_id]      = id
          h[:page_plan_id]  = page_plan.id
          h[:page_number]   = page_plan.page_number
          h[:section_name]  = page_plan.section_name
          h[:ad_type]       = page_plan.ad_type
          p                 = Page.create!(h)
        else
          # look for page_number and ad_type specified template
          template = PageLayout.where(page_type: page_number, ad_type: ad_type).first
          # If not found, look for odd even  tempate
          unless template
            page_type = page_number.odd? ? '101' : '102'
            template = PageLayout.where(page_type: page_type, ad_type: page_plan.ad_type).first
            unless template
              page_type = '100'
              template = PageLayout.where(page_type: page_type, ad_type: page_plan.ad_type).first
            end
          end
          if template
            h = {}
            h[:issue_id]      = id
            h[:page_plan_id]  = page_plan.id
            h[:page_number]   = page_plan.page_number
            h[:section_name]  = page_plan.section_name
            h[:template_id]   = template.id
            h[:ad_type]       = page_plan.ad_type
            h[:column] = template.column
            h[:color_page]    = page_plan.color_page
            p                 = Page.create!(h)
            page_plan.page    = p
            page_plan.dirty   = false
            page_plan.save
          end
          unless template
            # if thing is found, go for ad_type only
            template ||= PageLayout.where(ad_type: page_plan.ad_type).first
          end
          unless template
            # if still thing is found, go '광고없음' as last resort!!!
            ad_type = '광고없음'.unicode_normalize
            template = PageLayout.where(ad_type: ad_type).first
            # template = PageLayout.where(ad_type: 'NO_AD').first
            h = {}
            h[:issue_id]      = id
            h[:page_plan_id]  = page_plan.id
            h[:page_number]   = page_plan.page_number
            h[:section_name]  = page_plan.section_name
            h[:template_id]   = template.id
            h[:ad_type]       = page_plan.ad_type
            h[:color_page]    = page_plan.color_page
            p                 = Page.create!(h)
            page_plan.page    = p
            page_plan.dirty   = false
            page_plan.save
            puts "we need PageLayout for #{page_plan.ad_type}!!!!!"
          end
        end
      end
    end
  end

  def page_plan_with_ad
    list = []
    page_plans.each do |pp|
      list << pp if pp.ad_type
    end
    list
  end

  def ad_list
    list = []
    pages.each do |page|
      list << page.ad_info if page.ad_info
    end
    return false unless list.empty?

    list.to_yaml
  end

  def save_ad_info
    system("mkdir -p #{issue_ads_path}") unless File.directory?(issue_ads_path)
    File.open(issue_ad_list_path, 'w') { |f| f.write.ad_list } if ad_list
  end

  def parse_images
    Dir.glob("#{issue_images_path}/*{.jpg,.pdf}").each do |image|
      puts "+++++ image:#{image}"
      h = {}
      issue_image_basename = File.basename(image)
      profile_array = issue_image_basename.split('_')
      puts "profile_array:#{profile_array}"
      next if profile_array.length < 2

      puts "profile_array.length:#{profile_array.length}"
      # h[:image_path]        = image
      h[:page_number]       = profile_array[0].to_i
      h[:story_number]      = profile_array[1].to_i
      h[:column]            = 2
      h[:column]            = profile_array[2].to_i if profile_array.length > 3
      h[:landscape]         = true
      h[:caption_title]     = '사진설명 제목'
      h[:caption]           = '사진설명은 여기에 사진설명은 여기에 사진설명은 여기에 사진설명'
      h[:position]          = 3 # top_right 상단_우측
      # TODO read image file and determin orientaion from it.
      h[:used_in_layout]    = false
      h[:landscape]         = profile_array[3] if profile_array.length > 4
      h[:row] = if h[:landscape]
                  h[:column]
                else
                  h[:column] + 1
                end
      h[:extra_height_in_lines] = h[:row] * publication.lines_per_grid
      h[:issue_id] = id
      # h[:column]            = profile_array[2] if  profile_array.length > 3
      page = Page.where(issue_id: self, page_number: h[:page_number]).first
      puts "h[:issue_id]:#{h[:issue_id]}"
      puts "h[:page_number]:#{h[:page_number]}"
      unless page
        puts "Page: #{h[:page_number]} doesn't exist!!!!"
        next
      end
      working_article = WorkingArticle.where(page_id: page.id, order: h[:story_number]).first
      if working_article
        h[:working_article_id] = working_article.id
        puts "h:#{h}"
        Image.where(h).first_or_create
      # TODO: create symbolic link
      else
        puts "article at page:#{h[:page_number]} story_number: #{h[:story_number]} not found!!!}"
      end
    end
  end

  def parse_ad_images
    Dir.glob("#{issue_ads_path}/*{.jpg,.pdf}").each do |ad|
      h = {}
      h[:image_path]        = ad
      h[:issue_id]          = self
      AdImage.where(h).first_or_create
    end
  end

  def parse_graphics
    puts __method__
  end

  def ad_list
    list = []
    pages.each(&:ad_images)
  end

  def save_issue_plan_ad
    pages.each(&:save_issue_plan_ad)
  end

  def copy_sample_ad
    pages.each(&:copy_sample_ad)
  end

  def reset_issue_plan
    self.plan = File.open(default_issue_plan_path, 'r', &:read)
    save
    make_default_issue_plan
  end

  def prepare
    read_issue_plan
  end

  def spread_ad_width
    publication.spread_width
  end

  def spread_left_page
    puts "pages.count:#{pages.count}"
    return if pages.count == 0

    half = pages.count / 2
    puts "half:#{half}"
    pages[half - 1]
  end

  def spread_right_page
    return if pages.count == 0
    half = pages.count / 2
    pages[half]
  end

  def change_heading_bg_image(heading_bg_image)
    source_path = heading_bg_image.heading_bg_image.file.file
    change_current_issue_first_page(source_path)
    change_publication_template_first_page(source_path)
  end

  def change_current_issue_first_page(source_path)
    current_first_page = pages.first
    FileUtils.cp(source_path, current_first_page.first_page_bg_image_path)
    current_first_page.page_heading.generate_pdf
    current_first_page.generate_pdf_with_time_stamp
  end

  def change_publication_template_first_page(source_path)
    current_publication_template_first_page_image_path = 
    FileUtils.cp(source_path, publication.first_page_bg_image_path)
  end

  def save_all_pages_as_default_page_library
    pages.all.each do |page|
      page.save_as_default_page_library
    end
  end

  #########################################
  ############# save html ##################
  #########################################

  def html_path
    path + "/html"
  end

  def html_front_page_path
    html_path + "/index.html"
  end

  def front_page_content
    "Front Page Content"
  end

  def save_front_page
    FileUtils.mkdir_p(html_path) unless File.exist?(html_path)
    File.open(html_front_page_path, 'w'){|f| f.write front_page_content}
  end

  def save_page_html
    pages.each_with_index do |p|
      p.save_html
    end
  end

  def save_page_html_images
    pages.each_with_index do |p|
      p.save_html_image
    end
  end

  def save_html
    save_front_page
    save_page_html_images
    save_page_html
  end

  def has_edition?
    pages.select{|p| p.edition == 'B' || p.edition == 'C'}.length > 0
  end

  def remove_folder
    system("rm -rf #{path}")
  end
  
  private

  def read_issue_plan
    self.page_count = publication.page_count
    if File.exist?(default_issue_plan_path)
      self.plan = File.open(default_issue_plan_path, 'r', &:read)
      true
    else
      puts "#{default_issue_plan_path} does not exist!!!"
      false
    end
  end
end
