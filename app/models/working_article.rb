# == Schema Information
#
# Table name: working_articles
#
#  id                           :integer          not null, primary key
#  announcement_color           :string
#  announcement_column          :integer
#  announcement_text            :string
#  body                         :text
#  bottom_line                  :integer          default(0)
#  boxed_subtitle_text          :string
#  boxed_subtitle_type          :integer
#  by_line                      :string
#  category_code                :integer
#  category_name                :string
#  column                       :integer
#  date                         :date
#  email                        :string
#  embedded                     :boolean
#  extended_line_count          :integer
#  frame_color                  :string
#  frame_sides                  :string
#  frame_thickness              :float
#  grid_height                  :float
#  grid_width                   :float
#  grid_x                       :integer
#  grid_y                       :integer
#  gutter                       :float
#  has_profile_image            :boolean
#  heading_columns              :integer
#  height_in_lines              :integer
#  image                        :string
#  inactive                     :boolean
#  is_front_page                :boolean
#  kind                         :string
#  left_line                    :integer          default(0)
#  on_left_edge                 :boolean
#  on_right_edge                :boolean
#  order                        :integer
#  overlap                      :text
#  page_heading_margin_in_lines :integer
#  page_number                  :integer
#  path                         :string
#  pillar_order                 :string
#  price                        :float
#  profile                      :string
#  profile_image_position       :string
#  publication_name             :string
#  pushed_line_count            :integer
#  quote                        :text
#  quote_alignment              :string
#  quote_box_column             :integer
#  quote_box_show               :boolean
#  quote_box_size               :integer
#  quote_box_type               :integer
#  quote_line_type              :string
#  quote_position               :integer
#  quote_v_extra_space          :integer
#  quote_x_grid                 :integer
#  reporter                     :string
#  right_line                   :integer          default(0)
#  row                          :integer
#  slug                         :string
#  subcategory_code             :string
#  subject_head                 :string
#  subtitle                     :text
#  subtitle_head                :string
#  subtitle_type                :string
#  title                        :text
#  title_head                   :string
#  top_line                     :integer          default(0)
#  top_position                 :boolean
#  top_story                    :boolean
#  y_in_lines                   :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  article_id                   :integer
#  page_id                      :integer
#  pillar_id                    :bigint
#
# Indexes
#
#  index_working_articles_on_article_id  (article_id)
#  index_working_articles_on_page_id     (page_id)
#  index_working_articles_on_pillar_id   (pillar_id)
#  index_working_articles_on_slug        (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (pillar_id => pillars.id)
#

# by_line
# price
# category_code

class WorkingArticle < ApplicationRecord
  # before & after
  before_create :init_article
  after_create :setup_article

  # belongs_to
  belongs_to :page
  belongs_to :pillar
  belongs_to :article, optional: true

  # has_one
  has_one :story
  has_one :group_image

  # has_many
  has_many :images, dependent: :delete_all
  has_many :graphics, dependent: :delete_all
  has_many :proofs
  # has_many :story_category
  # has_many :story_subcategory

  # accepts_nested_attributes_for
  accepts_nested_attributes_for :images

  # include
  include ArticleSavePdf
  include ArticleSplitable
  include PageSplitable
  include ArticleSwapable
  include RectUtils
  include ArticleSaveXml
  include WorkingArticleAutofit
  include WorkingArticleLayout
  include WorkingArticlePillarMethods
  include PageSavePdf
  include WorkingArticleOverlapable

  # include StorageBackupWorkingArticle
  # extend FriendlyId
  # friendly_id :make_frinedly_slug, :use => [:slugged]
  attr_reader :time_stamp

  # def page_friendly_string
  #   page.friendly_string
  # end

  # when working_article is split, we need to bumped up folder names

  def save_to_story
    s = Story.where(working_article_id: id).first
    if s
      s.date = page.date
      s.summitted_section = page.section_name
      s.category_name = page.section_name
      s.title = title
      s.subtitle = subtitle
      s.quote = quote
      s.body = body
      s.selected_for_web = true
      s.save
    else 
      if reporter.present?
        s = Story.where(working_article_id: id, user_id: reporter_id).first_or_create
        s.date = page.date
        s.summitted_section = page.section_name
        s.category_name = page.section_name
        s.title = title
        s.subtitle = subtitle
        s.quote = quote
        s.body = body
        s.selected_for_web = false
        s.save
      elsif body.match(/^# (.*)/).present?
        s = Story.where(working_article_id: id, user_id: id_by_reporter_name_from_body).first_or_create
        s.date = page.date
        s.summitted_section = page.section_name
        s.category_name = page.section_name
        s.title = title
        s.subtitle = subtitle
        s.quote = quote
        s.body = body
        s.selected_for_web = false
        s.save
      else
        puts "경고: 기자명이 없습니다!"
      end
    end
    s
  end

  def reporter_id
    if reporter.present?
      User.find_by(name: reporter).id
    end
  end

  def id_by_reporter_name_from_body
    body.match(/^# (.*)/)
    reporter_name = $1.to_s.sub("# ", "")
    User.find_by(name: reporter_name).id
  end

  def reporter_from_body
    # return unless reporter
    body.match(/^# (.*)/) if body && body != ""
    return $1.to_s.sub("# ", "") if $1
    return nil
  end

  def bump_up_path
    base_name = File.basename(path)
    new_base = (base_name.to_i + 1).to_s
    new_path = File.dirname(path) + "/#{new_base}"
    system("mv #{path} #{new_path}")
  end

  def make_frinedly_slug
    "#{page_friendly_string}_#{order}"
  end

  def page_path
    page.path
  end

  def order_to_path
    "/#{pillar_order.split("_").join("/")}"
  end

  def path
    if pillar_member?
      page.path + order_to_path
    else
      page.path + "/#{pillar_order}"
    end 
  end

  def proof_path
    page_path + "/#{order}/proof"
  end

  def url
    "/#{publication.id}/issue/#{page.issue.date.to_s}/#{page.page_number}/#{pillar_order.split("_").join("/")}"
  end

  def setup
    make_article_path
  end

  def images_path
    path + "/images"
  end

  def layout_path
    path + "/layout.rb"
  end

  def story_path
    path + "/story.md"
  end

  def pdf_path
    path + "/story.pdf"
  end

  def jpg_path
    path + "/story.jpg"
  end

  def latest_pdf_basename
    f = Dir.glob("#{path}/story*.pdf").sort.last
    File.basename(f) if f
  end

  def latest_jpg_basename
    f = Dir.glob("#{path}/story*.jpg").sort.last
    File.basename(f) if f
  end


  def pdf_image_path
    url + "/#{latest_pdf_basename}"
  end

  def page_number
    page.page_number
  end

  def jpg_image_path
    url + "/#{latest_jpg_basename}"
  end

  def image_path
    "/#{publication.id}/issue/#{page.issue.date.to_s}/images"
  end

  def article_info_path
    path + "/article_info.yml"
  end

  def issue
    page.issue
  end

  # stroy from same group
  def story_candidates
    Story.where(date: issue.date, group: page.section_name)
  end

  def approximate_char_count
    if article
      article.char_count  
    end
    0
  end

  def change_story(new_story)
    # update content with new story content
    # ArticleWorker.perform(path, @time_stamp, '내일신문' )
  end

  # def run_generate_pdf
  #   ArticleWorker.new.perform(path, nil)
  # end

  def mac_pdf
    puts __method__
    ArticleWorker.perform_async(path, nil)
  end

  def ruby_pdf
    ArticleRubyWorker.perform_async(path, nil)
  end

  def update_story_content(story)
    # update content with new story content
    # params['working_article']['title'] = @working_article.filter_to_title(params['working_article']['title'])
    # params['working_article']['subtitle'] = @working_article.filter_to_title(params['working_article']['subtitle'])
    # params['working_article']['body'] = @working_article.filter_to_markdown(params['w
    self.reporter       = story.reporter
    self.subject_head   = filter_to_title(story.subject_head) if story.subject_head
    self.title          = filter_to_title(story.title)
    self.subtitle       = filter_to_title(story.subtitle)
    self.body           = filter_to_markdown(story.body)
    self.price          = story.price  if story.price
    self.by_line        = story.by_line  if story.by_line
    self.category_code  = story.category_code  if story.category_code
    self.subcategory_code  = story.subcategory_code  if story.subcategory_code
    self.quote          = story.quote  if story.quote
    self.save
    save_article
    delete_old_files
    stamp_time
    generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
    update_reporter_story(story.body)
  end

  def update_reporter_story(body)
    if story
      story.update_story_from_article(body)
    end
  end

  def make_article_path
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end

  def save_article
    make_article_path
    save_layout
    save_story unless kind == '사진'
  end

  def update_pdf
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end

  def stamp_time
    t = Time.now
    h = t.hour
    @time_stamp = "#{t.day.to_s.rjust(2,'0')}#{t.hour.to_s.rjust(2,'0')}#{t.min.to_s.rjust(2,'0')}#{t.sec.to_s.rjust(2,'0')}"
  end

  def delete_old_files
    old_pdf_files = Dir.glob("#{path}/story*.pdf")
    old_jpg_files = Dir.glob("#{path}/story*.jpg")
    old_pdf_files += old_jpg_files
    old_pdf_files.each do |old|
      system("rm #{old}")
    end
  end

  def delete_folder
    system("rm -rf #{path}")
  end

  def stamped_pdf_file
    path + "/story#{@time_stamp}.pdf"
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

  def generate_pdf_with_time_stamp(options={})
    puts "+++++++++ in generate_pdf_with_time_stamp"
    pdf_starting = Time.now
    delete_old_files
    stamp_time
    if NEWS_LAYOUT_ENGINE == 'ruby'
      puts "+++++++++ processing pdf with ruby"
      save_article_pdf(time_stamp: @time_stamp, adjustable_height:options[:adjustable_height])
      update_pdf_chain unless options[:no_update_pdf_chain]
    else
      system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article .  -time_stamp=#{time_stamp}"
    end
    pdf_working_article_ending = Time.now
    puts "++++++ pdf working_article time: #{pdf_working_article_ending - pdf_starting} "

    page.generate_pdf_with_time_stamp
    pdf_page_ending = Time.now
    puts "++++++ pdf with page time: #{pdf_page_ending - pdf_starting} "
  end

  def save_article_pdf(options={})
    save_hash                     = {}
    save_hash[:article_path]      = path
    save_hash[:story_md]          = story_md
    save_hash[:layout_rb]         = layout_rb
    save_hash[:time_stamp]        = options[:time_stamp]
    save_hash[:adjustable_height] = options[:adjustable_height]
    new_extended_line_count = RLayout::NewsBoxMaker.new(save_hash)
  
    # RLayout::NewsBoxMaker.new(save_hash) should return new new_extended_line_count
    if options[:adjustable_height]
      update(extended_line_count: new_extended_line_count) if new_extended_line_count && new_extended_line_count != 0
    end
  end

  def generate_pdf
    # @time_stamp =  true
    save_article
    ArticleWorker.perform_async(path, nil, nil)
    # system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article . -custom=#{publication.name}"
    # copy_outputs_to_site
  end

  def site_path
    page_site_path + "/#{order}"
  end

  def page_site_path
    page.site_path
  end

  def copy_outputs_to_site
    FileUtils.mkdir_p site_path unless File.exist?(site_path)
    system "cp #{pdf_path} #{site_path}/"
    system "cp #{jpg_path} #{site_path}/"
  end

  def siblings
    page.siblings(self)
  end

  def character_count
    return 0 unless body
    body.length
  end

  def extended_line_height
    if extended_line_count.nil?
      return 0
    end
    extended_line_count * publication.body_line_height
  end

  def pushed_line_height
    if pushed_line_count.nil?
      return 0
    end
    pushed_line_count * publication.body_line_height
  end

  # def expandable?(line_count)
  #   expandable = false
  #   sybs = siblings
  #   sybs.each do |sybling|
  #     expandable = sybling.pushable?(line_count)
  #   end
  #   expandable
  # end

  # def pushable?(line_count)
  #   article_bottom_spaces_in_lines = 2
  #   if height_in_lines - line_count >= 7 
  #     return true
  #   elsif siblings.length > 0
  #     siblings.first.pushable?(line_count)
  #     return true
  #   end
  #   false
  # end

  # expandable? for pillar
  def expandable?(line_count)
    expandable = false
    bottom_syb = bottom_article_of_sibllings(self)
    bottom_syb.pushable?(line_count)
  end

  # pushable? for bottom of sibllings
  def pushable?(line_count)
    article_bottom_spaces_in_lines = 2
    if height_in_lines - line_count >= 7 
      return true
    end
    false
  end

  # sets extended_line_count as line_count
  def set_extend_line(line_count)
    return if line_count == extended_line_count
    self.extended_line_count = line_count
    self.save
    bottom_article = pillar.bottom_article_of_sibllings(self)
    if bottom_article.pushable?(line_count)
      bottom_article.push_line(line_count)
      generate_pdf_with_time_stamp
      save_extended_line_count_to_config_yml(line_count)
      page.generate_pdf_with_time_stamp
    else
      puts "bottom sibling not pushable!!!"
    end
  end

  # adds extended_line_count with new line_count
  def extend_line(line_count, options={})
    sibs = siblings
    # return unless sibs.first.pushable?(line_count)
    return if line_count == 0
    if self.extended_line_count
      self.extended_line_count += line_count
    else
      self.extended_line_count = line_count
    end
    self.save
    # sibs.each do |sybling|
    #   sybling.push_line(self.extended_line_count)
    # end
    bottom_article = pillar.bottom_article(self)
    bottom_articlepush_line(line_count)
    generate_pdf_with_time_stamp
    save_extended_line_count_to_config_yml(self.extended_line_count)
    page.generate_pdf_with_time_stamp unless options[:generate_pdf] == false
  end

  def save_extended_line_count_to_config_yml(line_count)
    config_path = page.config_path
    config_hash = YAML::load_file(config_path)
    frame_array = config_hash['story_frames'][order - 1]
    if frame_array.length == 4
        frame_array << {'extend'=> line_count} unless line_count == 0
    elsif frame_array.length >= 5 
      if  frame_array.last.class == Hash
        if line_count == 0
          frame_array.last.delete('extend')
          frame_array.pop if frame_array.last == {}
        else
          frame_array.last['extend'] = line_count
        end
      # support lagacy format
      elsif frame_array.last =~/^extend/
        frame_array.pop
        frame_array << {'extend'=> line_count}  unless line_count == 0
      else
        frame_array << {'extend'=> line_count}  unless line_count == 0
      end
    end
    File.open(config_path, 'w'){|f| f.write config_hash.to_yaml}
  end

  def save_pushed_line_count_to_config_yml(line_count)
    config_path = page.config_path
    config_hash = YAML::load_file(config_path)
    frame_array = config_hash['story_frames'][order - 1]
    if frame_array.length == 4
        frame_array << {'push'=> line_count} unless line_count == 0
    elsif frame_array.length >= 5 
      if  frame_array.last.class == Hash
        if line_count == 0
          frame_array.last.delete('push')
          frame_array.pop if frame_array.last == {}
        else
          frame_array.last['push'] = line_count
        end
      # support lagacy format
      elsif frame_array.last =~/^push/
        frame_array.pop
        frame_array << {'push'=> line_count}  unless line_count == 0
      else
        frame_array << {'push'=> line_count}  unless line_count == 0
      end
    end
    File.open(config_path, 'w'){|f| f.write config_hash.to_yaml}
  end

  def push_line(line_count, options={})
    self.pushed_line_count = line_count
    self.save
    generate_pdf_with_time_stamp
    save_pushed_line_count_to_config_yml(self.pushed_line_count)
  end

  def empty_lines_count
    h = article_info
    return nil unless h
    h[:empty_lines]
  end

  def overflow?
    overflow_line_count
  end

  def underflow?
    empty_lines_count
  end

  def overflow_line_count
    h = article_info
    return nil unless h
    h[:overflow_line_count]
  end

  def show_quote_box?
    quote_box_show
  end
  
  def show_quote_box(quote_box_type)
    self.quote_box_show = true
    self.quote_box_type = quote_box_type
    case quote_box_type
    when '일반' || 'reqular'
      self.quote_box_size = 4
    when '기고2행' || 'opinion2'
      self.quote_box_size = 2
    when '기고3행' || 'opinion3'
      self.quote_box_size = 3
    end
    self.save
  end

  def hide_quote_box
    self.quote_box_show = false
    self.save
  end
 
  def boxed_subtitle_zero
    self.boxed_subtitle_type = 0
    self.save
  end

  def boxed_subtitle_one
    self.boxed_subtitle_type = 1
    self.save
  end

  def boxed_subtitle_two
    self.boxed_subtitle_type = 2
    self.save
  end

  def announcement_zero
    update(announcement_column:0)
  end

  def announcement_one
    update(announcement_column:1)
  end

  def announcement_two
    update(announcement_column:2)
  end


  def update_page_pdf
    page_path = page.path
    system "cd #{page_path} && /Applications/newsman.app/Contents/MacOS/newsman section ."
  end

  def update_page_pdf_with_time_stamp
    page_path = page.generate_pdf_with_time_stamp
    system "cd #{page_path} && /Applications/newsman.app/Contents/MacOS/newsman section ."
  end

  def article_info
    if File.exist?(article_info_path)
      return @article_info_hash ||= YAML::load(File.open(article_info_path, 'r'){|f| f.read})
    else
      puts "#{article_info_path} does not exist!!!"
      return nil
    end
  end

  def filtered_title
    RubyPants.new(title).to_html
  end

  def story_metadata
    h = {}
    h['extended_line_count']  = extended_line_count if extended_line_count && extended_line_count > 0
    h['pushed_line_count']    = pushed_line_count if pushed_line_count && pushed_line_count > 0
    h['subject_head']         = RubyPants.new(subject_head).to_html if subject_head && subject_head !=""
    h['title']                = RubyPants.new(title).to_html if title
    if subtitle
      h['subtitle']           = RubyPants.new(subtitle).to_html unless (kind == '사설' || kind == '기고')
    end
    h['boxed_subtitle_text']  = RubyPants.new(boxed_subtitle_text).to_html if boxed_subtitle_type && boxed_subtitle_type.to_i > 0
    h['quote']                = RubyPants.new(quote).to_html  if quote && quote !="" if quote_box_size.to_i > 0
    h['announcement']         = RubyPants.new(announcement_text).to_html  if announcement_column && announcement_column > 0
    h['reporter']             = reporter if reporter &&  reporter !=""
    h['email']                = email
    h
  end

  def story_yml
    h = {}
    h[:heading] = story_metadata
    h[:body]    = body
    h
  end

  def story_md
    story_md =<<~EOF
    #{story_metadata.to_yaml}
    ---
    #{RubyPants.new(body).to_html if body}
    EOF
  end

  def publication
    page.issue.publication
  end

  def opinion_pdf_path
    publication.path + "/opinion/#{reporter}.pdf"
  end

  def opinion_jpg_path
    filtered_name = reporter
    filtered_name = reporter.split("_").first if reporter.include?("_")
    filtered_name = reporter.split("=").first if reporter.include?("=")
    "/1/opinion/images/#{filtered_name}.jpg"
  end

  # IMAGE_FIT_TYPE_ORIGINAL       = 0
  # IMAGE_FIT_TYPE_VERTICAL       = 1
  # IMAGE_FIT_TYPE_HORIZONTAL     = 2
  # IMAGE_FIT_TYPE_KEEP_RATIO     = 3
  # IMAGE_FIT_TYPE_IGNORE_RATIO   = 4
  # IMAGE_FIT_TYPE_REPEAT_MUTIPLE = 5
  # IMAGE_CHANGE_BOX_SIZE         = 6 #change box size to fit image source as is at origin

  def opinion_image_options
    profile_hash                  = {}
    profile_hash[:image_path]     = opinion_pdf_path
    profile_hash[:column]         = 1
    profile_hash[:row]            = 1
    if reporter == '내일시론'
      profile_hash[:extra_height_in_lines]= -3 # 7+5=12 lines
    else
      profile_hash[:extra_height_in_lines]= 5 # 7+5=12 lines
    end
    profile_hash[:stroke_width]   = 0
    profile_hash[:position]       = 1
    profile_hash[:is_float]       = true
    profile_hash[:fit_type]       = 2 # IMAGE_FIT_TYPE_HORIZONTAL
    profile_hash[:before_title]   = true
    profile_hash[:layout_expand]  = nil
    profile_hash
  end

  def profile_pdf_path
    filtered_name = reporter
    filtered_name = reporter.split("_").first if reporter.include?("_")
    filtered_name = reporter.split("=").first if reporter.include?("=")
    publication.path + "/profile/#{filtered_name}.pdf"
  end

  def profile_image_options
    profile_hash                          = {}
    profile_hash[:image_path]             = profile_pdf_path
    profile_hash[:inside_first_column]    = true
    profile_hash[:width_in_colum]         = 'half'
    profile_hash[:image_height_in_line]   = 7
    profile_hash[:bottom_room_margin]     = 2
    profile_hash[:extra_height_in_lines]  = 5 # 7+5=12 lines
    profile_hash[:stroke_width]           = 0
    profile_hash[:is_float]               = true
    profile_hash[:fit_type]               = 4
    profile_hash[:before_title]           = true
    profile_hash[:layout_expand]          = nil
    profile_hash
  end

  def image_options
    if images.first
      images.first.image_layout_hash
    else
      nil
    end
  end

  def image_box_options
    if images.first
      images.first.image_layout_hash
    else
      nil
    end  end

  def page_columns
    page.column
  end

  def grid_frame
    [grid_x, grid_y, column, row]
  end

  def grid_height
    publication.grid_height
  end

  def gutter
    publication.gutter
  end

  def width
    column*grid_width
  end

  def height
    h = row*grid_height
    if top_position?
      h -= page_heading_margin_in_lines*body_line_height
    end
    if pushed_line_count && pushed_line_count != 0
      h -= pushed_line_count*body_line_height
    end
    if extended_line_count && extended_line_count != 0
      h += extended_line_count*body_line_height
    end
    h
  end

  def grid_area
    column*row
  end

  def body_line_height
    grid_height/7
  end
  # def x
  #   grid_x*grid_width
  # end

  #TODO add to db field



  # def y
  #   y_position =  grid_y*grid_height
  #   if top_position?
  #     y_position += page_heading_margin_in_lines*body_line_height
  #   elsif pushed_line_count && pushed_line_count != 0
  #     y_position += pushed_line_count*body_line_height
  #   end
  #   y_position
  # end

  # def top_story?
  #   page.page_number == 1 && order == 1
  # end

  #TODO
  def top_story?
    return true if top_story
    return true if page.working_articles.first.kind != '기사' && order == 2
    false
  end

  # def get_page_heading_margin_in_lines
  #   return 0 unless top_position?
  #   page.page_heading_margin_in_lines
  #   n
  # end

  def layout_options
    h = {}
    h[:kind]                          = self.kind if kind
    h[:adjustable_height]             = adjustable_height?
    h[:subtitle_type]                 = self.subtitle_type || '1단' unless kind == '사진'
    h[:heading_columns]               = self.heading_columns if  heading_columns && heading_columns!= column && heading_columns != ""
    if kind == '사설' || kind == 'editorial'
        h[:has_profile_image]             = true if reporter
        h[:has_profile_image]             = false if reporter == ""
    end
    h[:page_number]                   = self.page_number
    h[:stroke_width]                  = 1 if kind == '사설' || kind == 'editorial'
    h[:column]                        = self.column
    
    h[:row]                           = self.row
    h[:extended_line_count]           = self.extended_line_count if extended_line_count
    h[:pushed_line_count]             = self.pushed_line_count   if pushed_line_count
    
    h[:height_in_lines]               = self.height_in_lines     if self.height_in_lines

    h[:grid_width]                    = self.grid_width
    h[:grid_height]                   = self.grid_height
    h[:gutter]                        = self.gutter
    h[:on_left_edge]                  = self.on_left_edge
    h[:on_right_edge]                 = self.on_right_edge
    h[:is_front_page]                 = self.is_front_page
    h[:top_story]                     = top_story?
    h[:top_story]                     = false   if kind == 'opinion' || kind == '기고'  || kind == 'editorial' || kind == '사설' 
    if kind == '기고' && row >= 10
      h[:empty_first_column]          = true 
      h[:adjustable_height]           = false
    end
    h[:top_position]                  = top_position?
    h[:page_heading_margin_in_lines]  = publication.page_heading_margin_in_lines(page.page_number)
    h[:bottom_article]                = page.bottom_article?(self)

    if boxed_subtitle_type && boxed_subtitle_type > 0
      h[:boxed_subtitle_type]         = self.boxed_subtitle_type
    end
    if announcement_column && announcement_column > 0
      h[:announcement_column]         = self.announcement_column
      h[:announcement_color]          = self.announcement_color
    end
    if show_quote_box?
      h[:quote_box_size]              = self.quote_box_size 
      h[:quote_position]              = self.quote_position || 5 
      h[:quote_x_grid]                = self.quote_x_grid  - 1 if self.quote_x_grid
      h[:quote_v_extra_space]         = self.quote_v_extra_space || 0
      h[:quote_alignment]             = self.quote_alignment || 'left'
      h[:quote_line_type]             = self.quote_line_type || '상하' #'박스'
      h[:quote_box_type]              = self.quote_box_type || '일반' #'일반, 기고2행, 기고3행'
      h[:quote_box_column]            = self.quote_box_column || 1
    end
    h[:article_bottom_spaces_in_lines]= 2         #publication.article_bottom_spaces_in_lines
    h[:article_line_thickness]        = 0.3       #publication.article_line_thickness
    h[:article_line_draw_sides]       = [0,0,0,1] #publication.article_line_draw_sides
    h[:draw_divider]                  = false     #publication.draw_divider
    h[:overlap]                       = overlap   if overlap
    h[:embedded]                      = embedded  if embedded
    h
  end

  def image_layout
    content = ""
    images.each do |image|
      content += "  news_image(#{image.image_layout_hash})\n"
    end
    content
  end

  def graphic_layout
    content = ""
    graphics.each do |graphic|
      content += "  news_image(#{graphic.graphic_layout_hash})\n"
    end
    content
  end

  def quote_layout
    quote_hash = {}
    # quote_hash[:quote]            = quote
    quote_hash[:position]         = quote_position || 1
    quote_hash[:x_grid]           = quote_x_grid
    quote_hash[:column]           = quote_box_size || 1
    quote_hash[:row]              = 1
    quote_hash[:v_extra_space]    = quote_v_extra_space
    quote_hash[:text_alignment]   = quote_alignment || 'left'
    quote_hash[:line_type]        = quote_line_type || '상하'
    "  news_quote(#{quote_hash})\n"
  end

  def layout_rb
    # h = h.to_s.gsub("{", "").gsub("}", "")
    h = layout_options
    if kind == '사진'
      if first_image = images.first
        h[:draw_frame] = false if first_image && first_image.draw_frame == false
        content = "RLayout::NewsImageBox.new(#{h}) do\n"
        image_hash = image_options
        # image_hash[:fit_type] = 3 # keep ratio
        image_hash[:expand] = [:width, :height]
        content += "  news_image(#{image_hash})\n"
        content += "end\n"
      elsif first_graphic = graphics.first 
        h[:draw_frame] = false if first_graphic && first_graphic.draw_frame == false
        content = "RLayout::NewsImageBox.new(#{h}) do\n"
        image_hash = first_graphic.graphic_layout_hash
        # image_hash[:fit_type] = 3 # keep ratio
        image_hash[:expand] = [:width, :height]
        content += "  news_image(#{image_hash})\n"
        content += "end\n"
      else
        h[:draw_frame] = true
        content = "RLayout::NewsImageBox.new(#{h}) do\n"
        # # image_hash[:fit_type] = 3 # keep ratio
        # image_hash= {}
        # image_hash[:expand]     = [:width, :height]
        # image_hash[:image_path] = nil
        # content += "  news_image(#{image_hash})\n"
        content += "end\n"
      end
    elsif kind == '만평'
      content = "RLayout::NewsComicBox.new(#{h}) do\n"
      if image_hash = image_options
        content += "  news_image(#{image_hash})\n"
      end
      content += "end\n"
    elsif kind == '사설' || kind == 'editorial'
      h[:article_line_draw_sides]  = [0,1,0,0]
      content = "RLayout::NewsArticleBox.new(#{h}) do\n"
      content += "  news_column_image(#{profile_image_options})\n" if reporter && reporter != "" # if page_number == 22
      content += "end\n"
    elsif kind == '기고'  || kind == 'opinion'
      h[:article_line_draw_sides]  = [0,1,0,1]
      content = "RLayout::NewsArticleBox.new(#{h}) do\n"
        content += "  news_image(#{opinion_image_options})\n"
      content += "end\n"
    else
      content = "RLayout::NewsArticleBox.new(#{h}) do\n"
      if images.length > 0
        content += image_layout
      end
      if graphics.length > 0
        content += graphic_layout
      end
      # if quote && quote != ""
      #   content += quote_layout
      # end
      content += "end\n"
    end
    content
  end

  def save_story
    File.open(story_path, 'w'){|f| f.write story_md}
  end

  def read_story
    File.open(story_path, 'r'){|f| f.read }
  end

  def save_layout
    layout = layout_rb
    File.open(layout_path, 'w'){|f| f.write layout}
  end

  def library_images
    publication.library_images
  end

  def box_xml
    # "<a xlink:href='/working_articles/#{id}'><image xlink:href='#{jpg_image_path}' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
    # "<a xlink:href='/working_articles/#{id}'><image xlink:href='#{pdf_image_path}' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
    "<a xlink:href='/working_articles/#{id}'><rect fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  end

  def parse_story
    source      = read_story
    begin
      if (md = source.match(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m))
        @contents = md.post_match
        @metadata = YAML.load(md.to_s)
      else
        @contents = source
      end
    rescue => e
      puts "YAML Exception reading #filename: #{e.message}"
    end
    self.kind           = @metadata['kind'] || 'article'
    self.title          = @metadata['title']
    self.title_head     = @metadata['title_head'] || nil
    self.subtitle       = @metadata['subtitle']
    self.subtitle_head  = @metadata['subtitle_type'] || nil
    self.body           = @contents
    self.reporter       = @metadata['reporter']
    self.email          = @metadata['email']
    self.has_profile_image = @metadata['has_profile_image']
    self.image          = @metadata['image']
    self.quote          = @metadata['quote']
    self.subject_head   = @metadata['subject_head']
  end

  def parse_article_info
    if article_info_hash = article_info
      self.kind           = article_info_hash[:kind]
      self.column         = article_info_hash[:column]
      self.row            = article_info_hash[:row]
      self.is_front_page  = article_info_hash[:is_front_page]
      self.top_story      = article_info_hash[:top_story]
      self.top_position   = article_info_hash[:top_position]
    end
  end

  # parse working_article info from copied article_template files
  def parse_article
    if article_info
      parse_article_info
      parse_story
    else
      #code
    end
  end

  def growable?
    true
  end

  def section_name_code
    case page.section_name
    when '1면'
      code = "0009"
    when '정치'
      code = "0002"
    when '자치행정'
      code = "0003"
    when '국제통일'
      code = "0004"
    when '금융'
      code = "0007"
    when '산업'
      code = "0006"
    when '기획'
      code= "0001"
    when '정책'
      code = "0005"
    when '오피니언'
      code = "0008"
    end
    code
  end
  
  def group_name
    case page.section_name
    when '1면'
      code = "first_group"
    when '정치'
      code = "second_group"
    when '자치행정'
      code = "third_group"
    when '국제통일'
      code = "fourth_group"
    when '금융'
      code = "fifth_group"
    when '산업'
      code = "sixth_group"
    when '기획'
      code= "senventh_group"
    when '정책'
      code = "eighth_group"
    when '오피니언'
      code = "nineth_group"
    else
      code = "first_group"
    end

  end

  def news_class_large_id
    case page.section_name
    when '1면'
      code = "9"
    when '정치'
      code = "2"
    when '자치행정'
      code = "3"
    when '국제통일'
      code = "4"
    when '금융'
      code = "7"
    when '산업'
      code = "6"
    when '기획'
      code= "1"
    when '정책'
      code = "5"
    when '오피니언'
      code = "8"
    end
    code
  end

  def opinion_image_path
    publication.path + "/opinion/images"
  end

  def profile_image_path
    publication.path + "/profile/images"
  end

  def character_count_data_path
    publication.publication_info_folder + "/charater_count_data/#{Date.today.to_s}_#{page_number}_#{order}"
  end

  # we want to create a compiled database of actual character count on a working_article.
  # save a yaml file of actual instance character data
  # we can average them later as we gather more data
  def save_character_count
    info = article_info
    return unless info
    return unless info[:overflow] == 0

    useage_data   = Hash[attributes.map{ |k, v| [k.to_sym, v] }]
    useage_data.delete[:id]
    useage_data.delete[:updated_at]
    useage_data.delete[:updated_at]
    useage_data[:character_count] = character_count
    path = character_count_data_path
    File.open(path, 'w'){|f| f.write useage_data.to_yaml}
  end

  def calculate_fitting_image_size(image_column, image_row, image_extra_line)
    room = empty_lines_count
    image_info = [image_column, image_row, image_extra_line]
    if room < image_column
      # current image size is good fit
      return [image_column, image_row, image_extra_line]
    elsif room >= image_column
      # There is a room, so image size can grow
      extra_line_count = room % image_column
      extra_line_sum = extra_line_count  + image_extra_line
      if extra_line_sum > 7
        extra_rows = (extra_line_sum/7).to_i
        extra_lines = extra_line_sum % 7
        return [image_column, image_row + extra_rows, extra_lines]
      else
        extra_lines = extra_line_sum % 7
        return [image_column, image_row, extra_lines]
      end
    else
      # There is an overflow, so image size should be reduced
      current_image_occupied_lines = image_column*image_row*7 + image_column*image_extra_line
      overflow_row_count = (overflow_line_count/(image_column*7)).to_i
      overflow_extra_lines = overflow_line_count % image_column
      overflow_extra_lines_sum = overflow_extra_lines - image_extra_line
      if overflow_line_count > current_image_occupied_lines || overflow_row_count >= image_row
        # over flow is greater than the total image ares, so make the image as small as we can
        return [1,1,0]
      else
        return  [image_column, reducing_rows - overflow_row_count, overflow_extra_lines_sum]
      end
    end
  end

  def create_image_place_holder(column, row)
    image_hash                      = {}
    image_hash[:working_article_id] = id
    image_hash[:column]             = column
    image_hash[:row]                = row
    image_hash[:position]           = 3
    place_holder = Image.where(image_hash).first_or_create
    return true if place_holder
  end

  def create_place_holder_graphic(column, row)
    image_hash                      = {}
    image_hash[:working_article_id] = id
    image_hash[:column]             = column
    image_hash[:row]                = row
    image_hash[:position]           = 3
    place_holder = Graphic.where(image_hash).first_or_create
    return true if place_holder
  end


  # this is called when story was un_assigned from working_article
  def clear_story
    self.title          = "#{order}번 제목은 여기에 여기는 제목"
    self.subtitle       = '부제는 여기에 여기는 부제목 자리'
    self.reporter       = ''
    self.email          = 'gdhong@gmail.com'
    self.body =<<~EOF
    여기는 본문이 입니다 본문을 여기에 입력 하시면 됩니다. 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.
    여기는 본문이 입니다 본문을 여기에 입력 하시면 됩니다. 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.
    여기는 본문이 입니다 본문을 여기에 입력 하시면 됩니다. 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.
    여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.
    여기는 본문이 입니다 본문을 여기에 입력 하시면 됩니다. 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.
    EOF
    self.save
    generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
  end

  def layout_info
    layout_info = [grid_x, grid_y, column, row]
    h = {}
    if kind != '기사'
      h = {kind: kind}
    end
    h[:extended]  = extended_line_count if extended_line_count && extended_line_count != 0
    h[:pushed]    = pushed_line_count   if pushed_line_count && pushed_line_count != 0
    if images.length > 0
      h[:images] = []
      images.each do |image|
        h[:images] << image.info
      end
    end
    if graphics.length > 0
      h[:graphics] = []
      graphics.each do |graphic|
        h[:graphics] << graphic.info
      end
    end
    layout_info << h unless h == {}
    layout_info
  end


  def height_in_lines
    if extended_line_count && pushed_line_count
      row*7 + extended_line_count - pushed_line_count
    else
      row*7
    end
  end

  def to_row_and_pushed(y_position_in_line)
    row = y_position_in_line/7
    pushed = y_position_in_line % 7
  end

  def update_extended_and_pushed
    self.pushed_line_count = 0 if self.pushed_line_count.nil?
    if pushed_line_count >= 7
      row_count              = pushed_line_count/7
      new_pushed_line_count  = pushed_line_count % 7
      self.grid_y            = grid_y + row_count
      self.pushed_line_count = new_pushed_line_count
      self.y_in_lines        = grid_y*7 + new_pushed_line_count
    else
      self.y_in_lines        = row*7 + pushed_line_count
    end

    self.extended_line_count = 0 if self.extended_line_count.nil?
    if extended_line_count >= 7
      row_count = extended_line_count/7
      new_extendted_line_count = extended_line_count % 7
      self.row += row_count
      self.extended_line_count = new_extendted_line_count
    end
    self.height_in_lines = self.row*7 + self.extended_line_count - y_in_lines
    self.save
  end

  def node_order
    a = pillar_order.split("_")
    a.shift
    r = a.join("_")
    r
  end

  def v_cut_at(cut_index)
    # binding.pry
    # divide working article into two
    action = []
    if cut_index > 0
      # cut from left, , cut_index is positive value
      changing_column = cut_index
      new_column = column - cut_index
      new_grid_x = cut_index
      actions = [node_order, "v+#{cut_index}"]
    else
      # cut from right, cut_index is negative value
      changing_column = column + cut_index
      new_column = cut_index.abs
      new_grid_x = changing_column
      actions = [node_order, "v#{cut_index}"]
    end
    changing_pillar_order             = "#{pillar_order}_1"
    new_pillar_order                  = "#{pillar_order}_2"
    pillar.update_working_article_cut(actions)
    update(column: changing_column, pillar_order: changing_pillar_order)
    # delete current working_article content to new folder
    delete_folder # renane_folder?
    # update wokring_articlr in new folder and generate pdf
    # do not update_pdf_chain, since newly creating article will do it
    generate_pdf_with_time_stamp(no_update_pdf_chain: true)
    # create new working_article 
    h = { page: page, pillar: self, pillar_order: "#{new_pillar_order}", grid_x: new_grid_x, grid_y: 0, column: new_column, row: row }
    w = WorkingArticle.where(h).first_or_create
    w.update_pdf_chain
  end
  
  def bumpup_pillar_order_by(count)
    a = pillar_order.split("_")
    new_order = a.last.to_i + count
    a[-1] = new_order
    new_pillar_order = a.join("_")
    update(pillar_order: new_pillar_order)
  end

  def next_pillar_order
    a = pillar_order.split("_")
    new_order = a.last.to_i + 1
    a[-1] = new_order
    new_pillar_order = a.join("_")
  end


  def pillar_siblings
    pillar.pillar_siblings_of(self)
  end

  def following_pillar_siblings
    pillar.following_pillar_siblings_of(self)
  end

  # divide working_article horizontally
  def h_cut
    actions                       = [node_order, "h*1"]
    new_pillar_order              = next_pillar_order
    changing_row                  = row/2
    new_grid_y                    = grid_y + changing_row
    new_row                       = row - changing_row
    update(row: changing_row)
    generate_pdf_with_time_stamp(no_update_pdf_chain: true)
    h = { page: page, pillar: pillar, pillar_order: "#{new_pillar_order}", grid_x: 0, grid_y: new_grid_y, column: column, row: new_row }
    w = WorkingArticle.where(h).first_or_create
    following_pillar_siblings.each do |w|
      w.bumpup_pillar_order_by(1)
    end
    # update pillar_config file and working_article grid_y and row after cut
    pillar.update_working_article_cut(actions)
    w.generate_pdf_with_time_stamp

  end
  
  def layout_with_node_path
    [grid_x, grid_y, column,row, pillar_order.split("_")].unshift.join("_")
  end

  private


  def init_article
    self.grid_width  = page.grid_width
    self.grid_height = page.grid_height
    self.is_front_page = true if page.is_front_page?
    self.column = 4 unless column
    self.row = 4 unless row
    self.title = "여기는 #{pillar_order}제목 입니다." unless title
    self.title = "여기는 #{pillar_order}제목." if column <= 2
    self.subtitle = '여기는 부제목 입니다.' unless subtitle

    body_text = ""
    unit_text = '여기는 본문입니다. ' 
    area = self.column*self.row
    area.times do 
      body_text += unit_text
      body_text += "\n\n"
    end
    self.body = body_text
  end

  def setup_article
    make_article_path
    copy_from_sample
    # make_images_directory
    # generate_pdf_with_time_stamp
  end

  def copy_from_sample
    source = "#{Rails.root}/public/1/issue_sample/#{page_number}#{order_to_path}"
    if File.exist?(pdf_path)
    elsif File.exist?(source)
      system("cp -r #{source} #{path}/")
    else
      generate_pdf_with_time_stamp
    end
  end
end
