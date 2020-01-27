# frozen_string_literal: true

# == Schema Information
#
# Table name: issues
#
#  id             :integer          not null, primary key
#  date           :date
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

  include IssueStoryMakeable
  include IssueGitWorkflow
  include IssueSaveXml

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

  def relative_path
    "#{publication_id}/issue/#{date}"
  end

  def default_issue_plan_path
    "#{Rails.root}/public/#{publication_id}/default_issue_plan2.rb"
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
      page_ads << Section.available_ads_for(index + 1)
    end
    page_ads
  end

  def setup
    system "mkdir -p #{path}" unless File.directory?(path)
    copy_from_sample
    unless File.directory?(issue_images_path)
      system "mkdir -p #{issue_images_path}"
    end
    system "mkdir -p #{issue_ads_path}" unless File.directory?(issue_ads_path)
  end

  def copy_from_sample
    source = "#{Rails.root}/public/1/issue_sample"
    system("cp -r #{source}/ #{path}/")
  end

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

  def section_path
    "#{Rails.root}/public/#{publication_id}/section"
  end

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
    # plan
    # section_names_array = eval(publication.section_names)
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
        # create new page
        # page_type
        # 1 first page only
        # 100 even pages
        # 101 odd pages
        # 11 or with any other  specific page number
        # 22 with specific page number
        # 23 with specific page number
        page_number = i + 1
        # look for right template
        # first look for page_number and ad_type specified template
        ad_type = page_plan.ad_type.unicode_normalize
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
