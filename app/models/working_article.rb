# frozen_string_literal: true

# == Schema Information
#
# Table name: working_articles
#
#  id                           :integer          not null, primary key
#  ancestry                     :string
#  announcement_color           :string
#  announcement_column          :integer
#  announcement_text            :string
#  attached_position            :string
#  attached_type                :string
#  body                         :text
#  bottom_line                  :integer          default(0)
#  boxed_subtitle_text          :string
#  boxed_subtitle_type          :integer
#  by_line                      :string
#  category_code                :integer
#  category_name                :string
#  column                       :integer
#  date                         :date
#  drop_floor                   :integer          default(0)
#  email                        :string
#  embedded                     :boolean
#  extended_line_count          :integer
#  frame_bg_color               :string
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
#  image                        :string
#  inactive                     :boolean
#  is_front_page                :boolean
#  kind                         :string
#  left_line                    :integer          default(0)
#  locked                       :boolean
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

# ancestry
# keeps ancestry path(parent child relation info) in decence's ancestry field as /ancestry/path
# a root article can have attached articles(left_divide, right_divide, overlap, overlap)
# as children
# but left_drop and right_drop is not treated as child, they belong to pillar

# attached_types
# attached articles keep their attached_types info in this field
# divide, drop, overlap

# overlap
# overlapping area only one is allow
# we might have overlap or none or  overlap from page


class WorkingArticle < ApplicationRecord
  # before & after
  before_create :init_article
  after_create :setup_article

  # belongs_to
  belongs_to :page
  belongs_to :pillar
  belongs_to :article, optional: true

  has_one :story
  has_ancestry
  # has_many
  has_many :images, dependent: :delete_all
  has_many :graphics, dependent: :delete_all
  has_many :proofs
  has_one :group_image
  has_many :annotations
  # has_many :story_category
  # has_many :story_subcategory

  # accepts_nested_attributes_for
  accepts_nested_attributes_for :images

  include ArticleSwapable
  include RectUtils
  include ArticleSaveXml
  include WorkingArticleLayout
  include WorkingArticlePillarMethods
  include Pdf2jpg
  include WorkingArticleAttachment
  include WorkingArticleAnnotate
  include StaticWorkingArticle
  include GithubWorkingArticle
  include WorkingArticleFillupText
  include PageLibraryWorkingArticle
  serialize :overlap, Array # rect array
                            
  # extend FriendlyId
  # friendly_id :make_frinedly_slug, :use => [:slugged]
  attr_reader :time_stamp

  # def page_friendly_string
  #   page.friendly_string
  # end

  def default_height_in_lines
    # for root article
    if attached_type.nil?
      # return pillar.default_article_height_in_lines[order] 
      row*7
    elsif attached_type == '나눔' || attached_type == 'divide'
    # for attached types
      return parent.default_height_in_lines 
    elsif attached_type == '내림' || attached_type == 'drop'
      return parent.drop_height_in_lines      
    elsif attached_type == '쪽기사' || attached_type == 'overlap'
      return 14 
    end
  end

  def save_as_page_layout(position)
    atts = {}
    if kind == '기사' || kind == nil
      if images.length > 0 || graphics.length > 0
        atts[:kind]     =  기사
        atts[:images]   = images_as_page_layout if images.length > 0 
        atts[:graphics] =  images_as_page_layout if graphics.length > 0 
      end
    else
      atts[:kind]       =  kind
      atts[:images]     = images_as_page_layout if images.length > 0 
      atts[:graphics]   = images_as_page_layout if graphics.length > 0 
    end
    h = {}
    h[position] = atts unless atts == {}
    return nil if h == {}
    h
  end

  def images_as_page_layout
    images.map do |i|
      i.save_as_page_layout
    end
  end

  def graphics_as_page_layout
    graphics.map do |g|
      g.save_as_page_layout
    end
  end

  # when working_article is split, we need to bumped up folder names

  def page
    pillar.page if pillar
  end

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
        puts '경고: 기자명이 없습니다!'
      end
    end
    s
  end

  def reporter_id
    User.find_by(name: reporter).id if reporter.present?
  end

  def id_by_reporter_name_from_body
    body.match(/^# (.*)/)
    reporter_name = Regexp.last_match(1).to_s.sub('# ', '')
    User.find_by(name: reporter_name).id
  end

  def reporter_from_body
    # return unless reporter
    body.match(/^# (.*)/) if body && body != ''
    return Regexp.last_match(1).to_s.sub('# ', '') if Regexp.last_match(1)
    nil
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
    "/#{pillar_order.split('_').join('/')}"
  end

  def path
    if pillar_member?
      page.path + order_to_path
    else
      page.path + "/#{pillar_order}"
    end
  end

  def article_into_path
    path + "/article_info.yml"
  end

  def proof_path
    page_path + "/#{order}/proof"
  end

  def url
    "/#{publication.id}/issue/#{page.issue.date}/#{page.page_number}/#{pillar_order.split('_').join('/')}"
  end

  def setup
    make_article_path
  end

  def images_path
    path + '/images'
  end

  def layout_path
    path + '/layout.rb'
  end

  def layout_yaml_path
    path + '/layout.yml'
  end

  def story_path
    path + '/story.md'
  end

  def pdf_path
    path + '/story.pdf'
  end

  def jpg_path
    path + '/story.jpg'
  end

  def latest_pdf_basename
    f = Dir.glob("#{path}/story*.pdf").max
    File.basename(f) if f
  end

  def latest_jpg_basename
    f = Dir.glob("#{path}/story*.jpg").max
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
    "/#{publication.id}/issue/#{page.issue.date}/images"
  end

  def article_info_path
    path + '/article_info.yml'
  end

  def issue
    page.issue
  end

  # stroy from same group
  def story_candidates
    Story.where(date: issue.date, group: page.section_name)
  end

  def approximate_char_count
    body.length
  end

  def change_story(new_story)
    # update content with new story content
    # ArticleWorker.perform(path, @time_stamp, '내일신문' )
  end

  def update_story_content(story)
    self.reporter = story.reporter
    if story.subject_head
      self.subject_head = filter_to_title(story.subject_head)
    end
    self.title          = filter_to_title(story.title) if story.title
    self.subtitle       = filter_to_title(story.subtitle) if story.subtitle
    self.body           = filter_to_markdown(story.content.to_plain_text) if story.content
    self.price          = story.price if story.price
    self.by_line        = story.by_line if story.by_line
    self.category_code  = story.category_code if story.category_code
    self.quote = story.quote if story.quote
    self.save
    save_article
    delete_old_files
    stamp_time
    generate_pdf_with_time_stamp
    page.generate_pdf_with_time_stamp
    update_reporter_story(story.body)
  end

  def update_reporter_story(body)
    story.update_story_from_article(body)
  end

  def make_article_path
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end

  def save_article(options={})
    make_article_path
    save_layout(options)
    save_story unless kind == '사진'
  end

  def update_pdf
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end

  def stamp_time
    t = Time.now
    h = t.hour
    @time_stamp = "#{t.day.to_s.rjust(2, '0')}#{t.hour.to_s.rjust(2, '0')}#{t.min.to_s.rjust(2, '0')}#{t.sec.to_s.rjust(2, '0')}"
  end

  def delete_old_files
    old_pdf_files = Dir.glob("#{path}/story*.pdf")
    old_jpg_files = Dir.glob("#{path}/story*.jpg")
    old_pdf_files += old_jpg_files
    old_pdf_files.each do |old|
      system("rm #{old}")
    end
  end

  def delete_working_article
    delete_folder
    delete_attached_floats
    destroy
  end

  def delete_folder
    system("rm -rf #{path}")
  end

  def delete_attached_floats
    images.all.each {|i| i.destroy}
    graphics.all.each {|i| i.destroy}
    group_image.destroy if group_image
    story.destroy if story
  end

  def stamped_pdf_file
    path + "/story#{@time_stamp}.pdf"
  end

  def wait_for_stamped_pdf
    starting = Time.now
    times_up = starting + 60 * 1
    until File.exist?(stamped_pdf_file)
      sleep(1)
      if Time.now > times_up
        puts 'Waited for 5 seconds!!! Time is up brake'
        break
      end
    end
  end

  def read_height
    article_info = YAML::load_file(article_into_path)
    article_info[:image_height]
  end

  def read_height_in_lines
    return nil unless File.exist?(article_into_path)
    article_info = YAML::load_file(article_into_path)
    article_info[:height_in_lines].to_i
  end

  def update_height_in_lines_from_pdf
    new_height_in_lines     = read_height_in_lines
    new_extended_line_count = new_height_in_lines - default_height_in_lines
    if extended_line_count != new_extended_line_count
      update(extended_line_count: new_extended_line_count)
    end
    # TODO update attached
  end

  def generate_pdf_with_time_stamp(options = {})
    unless File.exist?(path)
      puts "article folder is not created !!!"
      return 
    end
    puts "generate_pdf... #{path}"
    delete_old_files
    save_article_pdf(options)
  end 
  alias gen_pdf generate_pdf_with_time_stamp

  def save_article_pdf(options = {})
    make_article_path
    save_article(options)
    save_hash                     = {}
    save_hash[:time_stamp]        = true
    save_hash[:article_path]      = path
    new_box_marker                = RLayout::NewsBoxMaker.new(save_hash)
    new_height_in_lines           = new_box_marker.new_height_in_lines.to_i
    new_extended_line_count       = new_height_in_lines - default_height_in_lines
    update(extended_line_count:new_extended_line_count)
    if extended_line_count != new_extended_line_count
      if attached_type == 'overlap'
        parent.update(overlap:overlap_rect)
      end
    end
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
    pillar.pillar_siblings_of(self)
  end

  def character_count
    return 0 unless body
    body.length
  end

  def extended_line_height
    return 0 if extended_line_count.nil?
    extended_line_count * body_line_height
  end

  # expandable? for pillar
  def expandable?(line_count)
    expandable = false
    bottom_syb = pillar.bottom_article
    bottom_syb.pushable?(line_count)
  end

  # pushable? for bottom of sibllings
  def pushable?(line_count)
    article_bottom_spaces_in_lines = 2
    return true if height_in_lines - line_count >= 7
    false
  end

  def available_bottom_space
    pillar.available_bottom_space
  end

  # auto adjust height of all ariticles in pillar and relayout bottom article
  # set height_in_lines, extended_line_count
  def auto_adjust_height_all
    pillar.auto_adjust_height_all
    pillar.page.generate_pdf_with_time_stamp 
  end

  # used for 글줄기 모두 0 행 복구
  def revert_all_extended_lines
    pillar.revert_all_extended_lines
  end

  # sets extended_line_count as line_count
  def set_extend_line(line_count)
    return if line_count == extended_line_count
    bottom_article = pillar.bottom_article
    unless bottom_article.pushable?(line_count)
      puts 'bottom sibling not pushable!!!'
      return
    end
    self.extended_line_count = line_count
    self.save
    generate_pdf_with_time_stamp
    if has_children?
      children.first.update(extended_line_count: extended_line_count)
      children.first.generate_pdf_with_time_stamp
    end
    bottom_article.update_bottom_height
    page.generate_pdf_with_time_stamp
  end

  # called to update height of bottom pillar article
  def update_bottom_height
    bottom_room_in_lines = pillar.bottom_article_room_in_lines
    y_in_lines = pillar.height_in_lines - bottom_room_in_lines
    update(y_in_lines: y_in_lines)
    bottom_room_in_lines = 14 if bottom_room_in_lines < 14
    generate_pdf_with_time_stamp(height_in_lines: bottom_room_in_lines)
    article_info = YAML::load_file(article_into_path)
    new_height_in_lines = article_info[:height_in_lines]
    new_extended_line_count = new_height_in_lines - default_height_in_lines
    update(extended_line_count: new_extended_line_count)
    page.generate_pdf_with_time_stamp
  end

  # adds extended_line_count with new line_count
  def extend_line(line_count, _options = {})
    return if line_count == 0
    bottom_article = pillar.bottom_article
    unless bottom_article.pushable?(line_count)
      puts 'bottom sibling not pushable!!!'
      return
    end
    self.extended_line_count += line_count
    self.save
    if attached_type == 'overlap'
      parent.update(overlap: overlap_rect)
    end
    generate_pdf_with_time_stamp
    if has_divide? || has_drop?
      children.first.update(extended_line_count: extended_line_count)
      children.first.generate_pdf_with_time_stamp
    end
    bottom_article.update_bottom_height
    page.generate_pdf_with_time_stamp
  end

  def pillar_bottom?
    pillar.bottom_article == self
    # pillar.pillar_bottom?(self)
    # max_grid_y == pillar.row
  end

  def max_grid_x
    grid_x + column
  end

  def max_grid_y
    grid_y + row
  end

  def page_bottomn_article?
    page.bottom_article?(self)
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
    case quote_box_type
    when '일반' || 'reqular'
      self.quote_box_size = 4
      self.quote_position = 5
      self.quote_position = 4 if kind == '기고'
    when '기고2행' || 'opinion2'
      self.quote_box_size = 2
      self.quote_position = 7
    when '기고3행' || 'opinion3'
      self.quote_box_size = 3
      self.quote_position = 7
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
    update(announcement_column: 0)
  end

  def announcement_one
    update(announcement_column: 1)
  end

  def announcement_two
    update(announcement_column: 2)
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
      @article_info_hash ||= YAML::load(File.open(article_info_path, 'r'){|f| f.read})
    else
      puts "#{article_info_path} does not exist!!!"
      nil
    end
  end

  def filtered_title
    RubyPants.new(title).to_html
  end

  def story_metadata
    h = {}
    h['top_story'] = top_story
    if extended_line_count && extended_line_count > 0
      h['extended_line_count']  = extended_line_count
    end
    if subject_head && subject_head != ''
      h['subject_head']         = RubyPants.new(subject_head).to_html
    end
    h['title'] = RubyPants.new(title).to_html if title
    if subtitle
      unless kind == '사설' || kind == '기고'
        h['subtitle'] = RubyPants.new(subtitle).to_html
      end
    end
    if boxed_subtitle_type && boxed_subtitle_type.to_i > 0
      h['boxed_subtitle_text'] = RubyPants.new(boxed_subtitle_text).to_html
    end
    if quote_box_size.to_i > 0 && quote && quote != ''
      h['quote'] = RubyPants.new(quote).to_html
    end
    if announcement_column && announcement_column > 0
      h['announcement'] = RubyPants.new(announcement_text).to_html
    end
    h['reporter']             = reporter if reporter && reporter != ''
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
    story_md = <<~EOF
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
    filtered_name = reporter.split('_').first if reporter.include?('_')
    filtered_name = reporter.split('=').first if reporter.include?('=')
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
    profile_hash[:extra_height_in_lines] = if reporter == '내일시론'
                                             -3 # 7+5=12 lines
                                           else
                                             5 # 7+5=12 lines
                                           end
    profile_hash[:stroke_width]   = 0
    profile_hash[:position]       = 1
    profile_hash[:is_float]       = true
    # profile_hash[:fit_type]       = 2 # IMAGE_FIT_TYPE_HORIZONTAL
    profile_hash[:fit_type]       = IMAGE_FIT_TYPE_VERTICAL
    profile_hash[:before_title]   = true
    profile_hash[:layout_expand]  = nil
    profile_hash
  end

  def profile_pdf_path
    filtered_name = reporter
    filtered_name = reporter.split('_').first if reporter.include?('_')
    filtered_name = reporter.split('=').first if reporter.include?('=')
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
    images.first.image_layout_hash if images.length > 0
  end

  def image_box_options
    images.first.image_layout_hash
  end

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

  def x
    grid_x * grid_width
  end

  def y
    # TODO: fix this use 
    if parent
      parent.y_in_lines*body_line_height
    end
    if y_in_lines
      y_in_lines*body_line_height
    else
      grid_y*grid_height
    end
  end

  def width
    column * grid_width
  end

  def height
    # h = row * grid_height
    # h -= page_heading_margin_in_lines * body_line_height if top_position?
    # h += extended_line_count * body_line_height
    read_height
    # h = (default_height_in_lines + extended_line_count)* body_line_height
    # h
  end

  def top_position?
    grid_y == 0 && pillar && pillar.top_position?
  end

  def pillar_top?
    grid_y == 0
  end

  def single_child?
    pillar.working_articles.length == 1
  end

  def y_max
    y + height
  end

  def grid_area
    column * row
  end

  def body_line_height
    grid_height / 7
  end

  def top_story?
    return true if top_story
    false
  end

  def height_in_lines
    #????
    # default_height_in_lines + extended_line_count
    if attached_type == 'overlap'
      return   row*7 + extended_line_count
    elsif attached_type == 'divide'
      parent.read_height_in_lines
    elsif attached_type == 'drop'
      pillar.height_in_lines - parent.y_in_line
    end
    read = read_height_in_lines
    return read  if read
    row*7
  end

  def layout_options
    h = {}
    h[:kind]                          = kind if kind
    # h[:has_attachment]                = has_children?
    h[:attached_type]                 = attached_type if attached_type
    h[:adjustable_height]             = adjustable_height?
    h[:subtitle_type] = subtitle_type || '1단' unless kind == '사진'
    if heading_columns && heading_columns != column && heading_columns != ''
      h[:heading_columns] = heading_columns
    end
    if kind == '사설' || kind == 'editorial'
      h[:has_profile_image] = true if reporter
      h[:has_profile_image] = false if reporter == ''
    end
    if frame_sides == '테두리'
      h[:frame_sides]                 = '테두리'
      h[:frame_bg_color]              = frame_bg_color || 'white'
      h[:frame_color]                 = frame_color || 'black'
      h[:frame_thickness]             = frame_thickness || 0.3
    end
    h[:page_number]                   = page_number
    h[:stroke_width]                  = 0.3 if kind == '사설' || kind == 'editorial'
    h[:column]                        = column
    h[:row]                           = row
    h[:height_in_lines]               = height_in_lines
    h[:grid_width]                    = grid_width
    h[:grid_height]                   = grid_height
    h[:gutter]                        = gutter
    h[:on_left_edge]                  = on_left_edge?
    h[:on_left_edge]                  = true if 'attached_type' == 'overlap'
    h[:on_right_edge]                 = on_right_edge?
    h[:is_front_page]                 = is_front_page
    h[:top_story]                     = top_story?
    if kind == 'opinion' || kind == '기고' || kind == 'editorial' || kind == '사설' || kind == '박스기사'
      h[:top_story]                     = false
    end
    if kind == '기고' && row >= 10
      h[:empty_first_column]          = true
      h[:adjustable_height]           = false
    end
    h[:top_position]                  = top_position?
    h[:bottom_article]                = page.bottom_article?(self)
    if boxed_subtitle_type && boxed_subtitle_type > 0
      h[:boxed_subtitle_type]         = boxed_subtitle_type
    end
    if announcement_column && announcement_column > 0
      h[:announcement_column]         = announcement_column
      h[:announcement_color]          = announcement_color
    end
    if show_quote_box?
      h[:quote_box_size]              = quote_box_size
      h[:quote_position]              = quote_position || 5
      h[:quote_x_grid] = quote_x_grid - 1 if quote_x_grid
      h[:quote_v_extra_space]         = quote_v_extra_space || 0
      h[:quote_alignment]             = quote_alignment || 'left'
      h[:quote_line_type]             = quote_line_type || '상하' # '박스'
      h[:quote_box_type]              = quote_box_type || '일반' # '일반, 기고2행, 기고3행'
      h[:quote_box_column]            = quote_box_column || 1
    end
    h[:article_bottom_spaces_in_lines] = 2 # publication.article_bottom_spaces_in_lines
    h[:article_line_thickness]        = 0.3 # publication.article_line_thickness
    h[:article_line_draw_sides]       = [0, 0, 0, 1] # publication.article_line_draw_sides
    h[:draw_divider]                  = false # publication.draw_divider
    if has_overlap?
      h[:overlap]             = overlap_of_child
    elsif attached_type == 'overlap'
      h[:height_in_lines]     = height_in_lines
      if attached_position == '우'
        h[:on_left_edge]        = true
        h[:on_right_edge]       = false
      else
        h[:on_left_edge]        = false
        h[:on_right_edge]       = true
      end
      h[:article_line_draw_sides]       = [0, 1, 0, 0] # publication.article_line_draw_sides
    end
    h[:embedded]      = embedded  if embedded
    h
  end

  def overlap_child
    children.select{|c| c.attached_type=='overlap'}.first
  end

  def overlap_of_child
    child_overlap_rect    = overlap_child.overlap_rect
    child_overlap_rect[0] -= grid_x
    child_overlap_rect[1] -= grid_y
    child_overlap_rect
  end

  # has_children? is ancestry method
  # is_root? is ancestry method

  def has_overlap?
    has_children? && children.map{|c| c.attached_type}.include?('overlap')
  end

  def has_divide?
    has_children? && children.map{|c| c.attached_type}.include?('divide')
  end

  def has_drop?
    has_children? && children.map{|c| c.attached_type}.include?('drop')
  end

  def image_layout
    content = ''
    # images.each do |image|
    # sort image by order
    images.sort_by(&:order).each do |image|
      content += "  news_image(#{image.image_layout_hash})\n"
    end
    content
  end

  def image_layout_hash
    images.sort_by(&:order).map do |image|
      image.image_layout_hash
    end
  end

  def graphic_layout
    content = ''
    graphics.sort_by(&:order).each do |graphic|
      content += "  news_image(#{graphic.graphic_layout_hash})\n"
    end
    content
  end

  def graphic_layout_hash
    graphics.sort_by(&:order).map do |graphic|
      graphic.graphic_layout_hash
    end
  end

  def group_image_layout
    "  news_float(#{group_image.group_image_layout_hash})\n"
  end

  def group_image_layout_hash
    group_image.group_image_layout_hash
  end

  def quote_layout
    quote_hash = {}
    quote_hash[:position]         = quote_position || 1
    quote_hash[:x_grid]           = quote_x_grid
    quote_hash[:column]           = quote_box_size || 1
    quote_hash[:row]              = 1
    quote_hash[:v_extra_space]    = quote_v_extra_space
    quote_hash[:text_alignment]   = quote_alignment || 'left'
    quote_hash[:line_type]        = quote_line_type || '상하'
    "  news_quote(#{quote_hash})\n"
  end

  def quote_layout_hash
    quote_hash = {}
    quote_hash[:position]         = quote_position || 1
    quote_hash[:x_grid]           = quote_x_grid
    quote_hash[:column]           = quote_box_size || 1
    quote_hash[:row]              = 1
    quote_hash[:v_extra_space]    = quote_v_extra_space
    quote_hash[:text_alignment]   = quote_alignment || 'left'
    quote_hash[:line_type]        = quote_line_type || '상하'
    quote_hash
  end

  def layout_rb(options={})
    h = layout_options
    h.merge!(options)
    h[:height_in_lines] = options[:fixed_height_in_lines] if options[:fixed_height_in_lines]
    if kind == '사진'
      if first_image = images.first
        h[:draw_frame] = false if first_image && first_image.draw_frame == false
        content = "RLayout::NewsImageBox.new(#{h}) do\n"
        image_hash = image_options 
        image_hash[:expand] = %i[width height]
        content += "  news_image(#{image_hash})\n"
        content += "end\n"
      elsif first_graphic = graphics.first
        if first_graphic && first_graphic.draw_frame == false
          h[:draw_frame] = false
        end
        content = "RLayout::NewsImageBox.new(#{h}) do\n"
        image_hash = first_graphic.graphic_layout_hash
        image_hash[:expand] = %i[width height]
        content += "  news_image(#{image_hash})\n"
        content += "end\n"
      else
        h[:draw_frame] = true
        content = "RLayout::NewsImageBox.new(#{h}) do\n"
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
      content += "  news_column_image(#{editorial_image_options})\n" if reporter && reporter != "" # if page_number == 22
      content += "end\n"
    elsif kind == '기고' || kind == 'opinion'
      h[:empty_first_column] = true if row >= 10
      h[:profile_image_position] = profile_image_position if profile_image_position && profile_image_position ==  "하단 오른쪽"
      h[:article_line_draw_sides]  = [0,1,0,1]
      content = "RLayout::NewsArticleBox.new(#{h}) do\n"
        if profile_image_position && profile_image_position ==  "하단 오른쪽"#
          content += "  news_image(#{opinion_profile_lower_right_options})\n"
        else
          content += "  news_image(#{opinion_profile_options})\n"
        end
        if images.length > 0
          content += image_layout
        end
        if graphics.length > 0
          content += graphic_layout
        end
      content += "end\n"
    else
      h[:profile_image_position] = profile_image_position if profile_image_position && profile_image_position ==  "하단 오른쪽"
      h[:article_line_draw_sides]  = [0,1,0,1]
      content = "RLayout::NewsArticleBox.new(#{h}) do\n"
      content += image_layout unless images.empty?
      content += graphic_layout unless graphics.empty?
      content += group_image_layout if group_image && group_image.ready?
      content += "end\n"
    end
    content
  end

  # use layout_yml instead of layout_rb
  # since layout_rb relies on eval, using yml will be more language neutral
  def layout_yaml(options={})
    h = layout_options
    h.merge!(options) if options !={}
    h[:pillar_order]    = pillar_order
    h[:grid_x]          = grid_x
    h[:grid_y]          = grid_y
    h[:column]          = column
    h[:row]             = row
    h[:grid_width]      = grid_width
    h[:grid_height]     = grid_height
    h[:height_in_lines] = options[:fixed_height_in_lines] if options[:fixed_height_in_lines]
    if kind == '사진'
      if first_image = images.first
        h[:draw_frame] = false if first_image && first_image.draw_frame == false
        h[:klass] = "NewsImageBox"
        h[:image_options] = image_options
      elsif first_graphic = graphics.first
        if first_graphic && first_graphic.draw_frame == false
          h[:draw_frame]  = false
        end
        h[:klass]         = "NewsImageBox"
        h[:image_options] = image_options
      else
        h[:draw_frame] = true
        h[:klass] = "NewsImageBox"
      end
    elsif kind == '만평'
      h[:klass]             = NewsComicBox
      h[:image_options]     = image_options
      if image_hash = image_options
        h[:image_options]   = image_options
      end
    elsif kind == '사설' || kind == 'editorial'
      h[:article_line_draw_sides]   = [0,1,0,0]
      h[:klass]                     = "NewsArticleBox"
      h[:image_options]             = editorial_image_options

    elsif kind == '기고' || kind == 'opinion'
      h[:empty_first_column]        = true if row >= 10
      h[:profile_image_position]    = profile_image_position if profile_image_position && profile_image_position ==  "하단 오른쪽"
      h[:article_line_draw_sides]   = [0,1,0,1]
      h[:klass] = "NewsArticleBox"
      if profile_image_position && profile_image_position ==  "하단 오른쪽"#
        h[:profile_options] = opinion_profile_lower_right_options
      else
        h[:profile_options] = opinion_profile_options
      end
      if images.length > 0
        h[:image_options] = image_layout_hash
      end
      if graphics.length > 0
        h[:graphic_options] = graphic_layout_hash
      end
    else
      h[:profile_image_position]    = profile_image_position if profile_image_position && profile_image_position ==  "하단 오른쪽"
      h[:article_line_draw_sides]   = [0,1,0,1]
      h[:klass]                     = "NewsArticleBox"
      h[:image_options]             = image_layout_hash unless images.empty?
      h[:graphic_options]           = graphic_layout_hash unless graphics.empty?
      h[:group_image_options]       = group_image_layout_hash if group_image && group_image.ready?
    end
    h.to_yaml
  end

  def pdf_path_from_page
    pdf_path.sub(page.path, "")
  end

  def layout_map
    h = {}
    h[:pdf_rect] = [x,y,width,height]
    h[:pdf_path] = pdf_path_from_page 
    h
  end

  def opinion_profile_pdf_path
    publication.path + "/opinion/#{reporter}.pdf"
  end

  def opinion_profile_jpg_path
    publication.path + "/opinion/#{reporter}.jpg"
  end

  def opinion_profile_options
    profile_hash                  = {}
    profile_hash[:image_path]     = opinion_profile_pdf_path
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
    profile_hash[:fit_type]       = 1 # IMAGE_FIT_TYPE_HORIZONTAL=2 , IMAGE_FIT_TYPE_VERTICAL =1, # IMAGE_FIT_TYPE_IGNORE_RATIO   = 4
    profile_hash[:before_title]   = true
    profile_hash[:layout_expand]  = nil
    profile_hash
  end

  def opinion_profile_lower_right_options
    profile_hash                          = {}
    profile_hash[:image_path]             = editorial_profile_pdf_path
    profile_hash[:inside_first_column]    = true
    profile_hash[:width_in_colum]         = 'half'
    profile_hash[:image_height_in_line]   = 7
    profile_hash[:bottom_room_margin]     = 2
    profile_hash[:extra_height_in_lines]  = 0 # 7+5=12 lines
    profile_hash[:stroke_width]           = 0
    profile_hash[:is_float]               = true
    profile_hash[:fit_type]               = IMAGE_FIT_TYPE_VERTICAL
    profile_hash[:before_title]           = false
    profile_hash[:layout_expand]          = nil
    profile_hash[:position]               = 9
    profile_hash
  end

  def editorial_profile_pdf_path
    publication.path + "/profile/#{reporter}.pdf"
  end

  def editorial_image_options
    profile_hash                          = {}
    profile_hash[:image_path]             = editorial_profile_pdf_path
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

  def save_story
    File.open(story_path, 'w') { |f| f.write story_md }
  end

  def read_story
    File.open(story_path, 'r', &:read)
  end

  def save_layout(options={})
    layout = layout_rb(options)
    File.open(layout_path, 'w') { |f| f.write layout }
  end

  def save_layout_yaml
    File.open(layout_yaml_path, 'w') { |f| f.write layout_yaml }
  end

  def library_images
    publication.library_images
  end

  def box_xml
    "<a xlink:href='/working_articles/#{id}'><rect fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' /></a>\n"
  end

  def parse_story
    source = read_story
    begin
      if (md = source.match(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m))
        @contents = md.post_match
        @metadata = YAML.safe_load(md.to_s)
      else
        @contents = source
      end
    rescue StandardError => e
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
      # code
    end
  end

  def growable?
    true
  end

  def section_name_code
    case page.section_name
    when '1면'
      code = '0009'
    when '정치'
      code = '0002'
    when '자치행정'
      code = '0003'
    when '국제통일'
      code = '0004'
    when '금융'
      code = '0007'
    when '산업'
      code = '0006'
    when '기획'
      code = '0001'
    when '정책'
      code = '0005'
    when '오피니언'
      code = '0008'
    end
    code
  end

  def group_name
    code = case page.section_name
    when '1면'
      'first_group'
    when '정치'
      'second_group'
    when '자치행정'
      'third_group'
    when '국제통일'
      'fourth_group'
    when '금융'
      'fifth_group'
    when '산업'
      'sixth_group'
    when '기획'
      'senventh_group'
    when '정책'
      'eighth_group'
    when '오피니언'
      'nineth_group'
    else
      'first_group'
    end
  end

  def news_class_large_id
    case page.section_name
    when '1면'
      code = '9'
    when '정치'
      code = '2'
    when '자치행정'
      code = '3'
    when '국제통일'
      code = '4'
    when '금융'
      code = '7'
    when '산업'
      code = '6'
    when '기획'
      code = '1'
    when '정책'
      code = '5'
    when '오피니언'
      code = '8'
    end
    code
  end

  def opinion_image_path
    publication.path + '/opinion/images'
  end

  def profile_image_path
    publication.path + '/profile/images'
  end

  def character_count_data_path
    publication.publication_info_folder + "/charater_count_data/#{Date.today}_#{page_number}_#{order}"
  end

  # we want to create a compiled database of actual character count on a working_article.
  # save a yaml file of actual instance character data
  # we can average them later as we gather more data
  def save_character_count
    info = article_info
    return unless info
    return unless info[:overflow] == 0

    useage_data = Hash[attributes.map { |k, v| [k.to_sym, v] }]
    useage_data.delete[:id]
    useage_data.delete[:updated_at]
    useage_data.delete[:updated_at]
    useage_data[:character_count] = character_count
    path = character_count_data_path
    File.open(path, 'w') { |f| f.write useage_data.to_yaml }
  end

  def calculate_fitting_image_size(image_column, image_row, image_extra_line)
    room = empty_lines_count
    image_info = [image_column, image_row, image_extra_line]
    if room < image_column
      # current image size is good fit
      [image_column, image_row, image_extra_line]
    elsif room >= image_column
      # There is a room, so image size can grow
      extra_line_count = room % image_column
      extra_line_sum = extra_line_count + image_extra_line
      if extra_line_sum > 7
        extra_rows = (extra_line_sum / 7).to_i
        extra_lines = extra_line_sum % 7
        [image_column, image_row + extra_rows, extra_lines]
      else
        extra_lines = extra_line_sum % 7
        [image_column, image_row, extra_lines]
      end
    else
      # There is an overflow, so image size should be reduced
      current_image_occupied_lines = image_column * image_row * 7 + image_column * image_extra_line
      overflow_row_count = (overflow_line_count / (image_column * 7)).to_i
      overflow_extra_lines = overflow_line_count % image_column
      overflow_extra_lines_sum = overflow_extra_lines - image_extra_line
      if overflow_line_count > current_image_occupied_lines || overflow_row_count >= image_row
        # over flow is greater than the total image ares, so make the image as small as we can
        [1, 1, 0]
      else
        [image_column, reducing_rows - overflow_row_count, overflow_extra_lines_sum]
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
    self.body = <<~EOF
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
    h = { kind: kind } if kind != '기사'
    if extended_line_count && extended_line_count != 0
      h[:extended]  = extended_line_count
    end

    unless images.empty?
      h[:images] = []
      images.each do |image|
        h[:images] << image.info
      end
    end
    unless graphics.empty?
      h[:graphics] = []
      graphics.each do |graphic|
        h[:graphics] << graphic.info
      end
    end
    layout_info << h unless h == {}
    layout_info
  end

  def to_row_and_pushed(y_position_in_line)
    row = y_position_in_line / 7
    pushed = y_position_in_line % 7
  end

  def node_order
    a = pillar_order.split('_')
    a.shift
    r = a.join('_')
    r
  end

  def layout_with_node_path
    [grid_x, grid_y, column, row, pillar_order.split('_')].unshift.join('_')
  end

  def sample_path
    "#{Rails.root}/public/1/sample/article/#{profile.split("_").join("/")}"
  end

  def copy_from_sample
    if File.exist?(pdf_path)
    else
      generate_pdf_with_time_stamp
    end
  end

  def on_left_edge?
    if attached_type.nil?
      pillar.grid_x == 0 && grid_x == 0
    elsif attached_type= 'divide' || attached_type= 'drop'
      if pillar.on_left_edge? && attached_position == '좌'
        true
      else
        false
      end
    elsif attached_type == 'overlap'
      if attached_position == '우'
        true
      else
        false
      end
    else
      false
    end
  end

  def on_right_edge?
    if attached_type.nil?
      pillar.grid_x + column == pillar.page.column
    elsif attached_type= 'divide' || attached_type= 'drop'
      if pillar.on_right_edge? && attached_position == '우'
        true
      else
        false
      end
    elsif attached_type == 'overlap'
      if attached_position == '우'
        false
      else
        false
      end    
    else
      false
    end
  end

  def self.read_layout_yaml_from_disk(layout_yaml_path)
    layout_hash       = YAML::load_file(layout_yaml_path).dup
    
    layout_hash.delete(:has_attachment)
    layout_hash.delete(:adjustable_height)
    layout_hash.delete(:height_in_lines)
    layout_hash.delete(:height_in_lines)
    layout_hash.delete(:bottom_article)
    layout_hash.delete(:article_bottom_spaces_in_lines)
    layout_hash.delete(:article_line_thickness)
    layout_hash.delete(:article_line_draw_sides)
    layout_hash.delete(:draw_divider)
    layout_hash.delete(:klass)

    
    article_info_path = layout_yaml_path.sub("layout.yml", "article_info.yml")
    article_info_hash = YAML::load_file(article_info_path).dup
    extended_line_count = article_info_hash[:extended_line_count]
    layout_hash[:extended_line_count] = extended_line_count
    layout_hash
  end

  private

  def init_article

    self.grid_width           = pillar.page.grid_width
    self.grid_height          = pillar.page.grid_height
    self.is_front_page        = true if pillar.page.is_front_page?
    self.grid_x               = 0 unless grid_x
    self.grid_y               = 0 unless grid_y
    self.column               = 4 unless column
    self.row                  = 4 unless row
    self.on_left_edge         = true if on_left_edge?
    self.on_right_edge        = true if on_right_edge?
    if column > 2 && (pillar_order == '1' || pillar_order == '1_1')
      self.top_story = true
    end
    self.extended_line_count  = extended_line_count || 0
    self.page_heading_margin_in_lines = pillar.page.page_heading_margin_in_lines
    if kind == '부고-인사'
      self.subject_head         = '부고' 
      self.reporter             = '홍길동' unless reporter
    else
      self.title                = "여기는 #{pillar_order} 제목 입니다." unless title
      self.title                = "여기는 #{pillar_order} 제목." if column <= 2
      self.subtitle             = '여기는 부제목 입니다.' unless subtitle
      self.reporter             = '홍길동' unless reporter
      self.profile              = "#{pillar.page.column}_#{column}x#{row}"
    end
    if self.top_story?
      self.profile            = "#{self.profile}_top-story"           
    elsif pillar.top_position? && grid_y == 0
      self.profile            = "#{self.profile}_top-position"        
    else
      self.profile            = "#{pillar.page.column}_#{column}x#{row}_middle"
    end
    body_text                 = ""
    unit_text                 = '여기는 본문입니다. ' 
    area                      = self.column*self.row
    body_text                 += unit_text
    body_text                 += "\n\n"
    self.body                 = body_text
  end

  def setup_article
    make_article_path
    copy_from_sample
  end

end
