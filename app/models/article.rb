# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id                           :integer          not null, primary key
#  grid_x                       :integer
#  grid_y                       :integer
#  column                       :integer
#  row                          :integer
#  order                        :integer
#  kind                         :string
#  profile                      :integer
#  title_head                   :string
#  title                        :text
#  subtitle                     :text
#  subtitle_head                :text
#  body                         :text
#  reporter                     :string
#  email                        :string
#  personal_image               :string
#  image                        :string
#  quote                        :text
#  subject_head                 :string
#  on_left_edge                 :boolean
#  on_right_edge                :boolean
#  is_front_page                :boolean
#  top_story                    :boolean
#  top_position                 :boolean
#  section_id                   :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  extended_line_count          :integer
#  pushed_line_count            :integer
#  publication_name             :string
#  path                         :string
#  page_heading_margin_in_lines :integer
#  grid_width                   :float
#  grid_height                  :float
#  gutter                       :float
#  overlap                      :text
#  embedded                     :boolean
#  y_in_lines                   :integer
#  height_in_lines              :integer
#

class Article < ApplicationRecord
  belongs_to :section # , optional: true
  before_create :init_atts
  before_save :init_atts
  after_create :setup
  has_many :images

  # def path
  #   section.path + "/#{order}"
  # end

  def has_pdf?
    File.exist?(pdf_path)
  end

  def images_path
    path + '/images'
  end

  def layout_path
    path + '/layout.rb'
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

  def relative_path
    section.relative_path + "/#{order}"
  end

  def pdf_image_path
    relative_path + '/story.pdf'
  end

  def jpg_image_path
    relative_path + '/output.jpg'
  end

  def custom_pdf_path
    path + '/custom_style.pdf'
  end

  def custom_jpg_path
    path + '/custom_style.jpg'
  end

  def custom_pdf_image_path
    relative_path + '/custom_style.pdf'
  end

  def custom_jpg_image_path
    relative_path + '/custom_style.end'
  end

  def article_info_path
    path + '/article_info.yml'
  end

  def publication
    section.publication
  end

  def create_folders
    system "mkdir -p #{path}" unless File.directory?(path)
    system "mkdir -p #{images_path}" unless File.directory?(images_path)
  end

  def setup
    create_folders
    save_story
    save_layout
  end

  def save_article
    save_story
    save_layout
  end

  def grid_area
    grid_x * grid_y
  end

  # approximation of character_count
  def char_count
    column * row * 7 * 15
  end

  def update_pdf_unless
    unless File.exist?(pdf_path)
      system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
    end
  end

  def update_pdf
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end

  def generate_pdf
    save_story
    save_layout
    # ArticleWorker.perform_async(path, nil)
    # system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article . -custom=#{publication_name}"
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end

  def generate_custom_style_pdf(current_styles)
    puts __method__
    styles_path = path + '/custom_style.yml'
    File.open(styles_path, 'w') { |f| f.write current_styles.to_yaml }
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article . -custom=#{publication_name}"
  end

  def article_info
    if File.exist?(article_info_path)
      @article_info_hash ||= YAML.safe_load(File.open(article_info_path, 'r', &:read))
    else
      puts "#{article_info_path} does not exist!!!"
      nil
    end
  end

  def x
    grid_x * grid_width
  end

  def y
    y_position = grid_y * grid_height
  end

  def width
    column * grid_width
  end

  def height
    h = row * grid_height
  end

  def box_svg
    "<rect class='rectfill' stroke='black' stroke-width='4' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{width}' height='#{height}' />\n"
  end

  def story_md
    title     = "#{order}번 기사 제목은 여기에"
    subtitle  = '부제는 여기에 여기는 부제목 자리'
    reporter  = ''
    email     = 'gdhong@gmail.com'

    body = <<~EOF
      여기는 본문이 입니다 본문을 여기에 입력 하시면 됩니다. 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.

      여기는 본문이 입니다 본문을 여기에 입력 하시면 됩니다. 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.

      여기는 본문이 입니다 본문을 여기에 입력 하시면 됩니다. 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.

      여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.

      여기는 본문이 입니다 본문을 여기에 입력 하시면 됩니다. 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다. 여기는 본문이 입니다.

    EOF

    quote           = "여기에 발문 입력 합니다.\r\n. 이부분은 본문 중간에 위치 하게 됩니다."
    extra_paragraph = "\n#{quote}" * 3

    story_md = if kind == '기고'
                 <<~EOF
                   ---
                   title: #{title}
                   reporter: #{reporter}
                   email: #{email}
                   ---

                   #{body}

                 EOF

               elsif kind == '사설' && page_number == 22
                 <<~EOF
                   ---
                   subject_head: 기고
                   title: #{title}
                   email: #{email}
                   ---

                   #{body}

                 EOF
               elsif kind == '사설' && page_number == 23
                 <<~EOF
                   ---
                   subject_head: 내일시론
                   title: #{title}
                   email: #{email}
                   ---

                   #{body}

                 EOF

               else
                 <<~EOF
                   ---
                   title: #{title}
                   subtitle: #{subtitle}
                   reporter: #{reporter}
                   email: #{email}
                   ---

                   #{body}

                 EOF
               end
  end

  def image_options
    # code
    images.first.image_layout_hash
  end

  def page_number
    section.page_number
  end

  def layout_rb
    # grid_width    = publication.grid_width(page_columns)
    # grid_height   = publication.grid_height
    # gutter        = publication.gutter
    image_options = image_options if image_options
    page_heading_margin_in_lines = 0
    if top_position
      if is_front_page
        # front_page_heading_height - lines_per_grid
        page_heading_margin_in_lines = publication.front_page_heading_margin
      elsif section.page_number == 22 || section.page_number == 23
        page_heading_margin_in_lines = 4
      else
        page_heading_margin_in_lines = publication.inner_page_heading_height
      end
    end
    h = {}
    h[:kind]                          = kind unless h[:kind] == '기사'
    h[:reporter]                      = '홍길동' if h[:kind] == '기고'
    h[:column]                        = column
    h[:row]                           = row
    h[:grid_width]                    = grid_width
    h[:grid_height]                   = grid_height
    h[:gutter]                        = gutter
    h[:on_left_edge]                  = on_left_edge
    h[:on_right_edge]                 = on_right_edge
    h[:is_front_page]                 = is_front_page
    h[:top_story]                     = top_story
    h[:top_position]                  = top_position
    h[:bottom_article]                = section.bottom_article?(self)
    h[:page_heading_margin_in_lines]  = page_heading_margin_in_lines
    h[:article_bottom_spaces_in_lines] = publication.article_bottom_spaces_in_lines
    h[:article_line_draw_sides]       = publication.article_line_draw_sides
    h[:article_line_thickness]        = publication.article_line_thickness
    h[:draw_divider]                  = publication.draw_divider
    h[:overlap]                       = overlap if overlap
    h[:embedded]                      = embedded if embedded
    content = <<~EOF
      RLayout::NewsArticleBox.new(#{h})

    EOF
    if kind == '기고'
      content = <<~EOF
        RLayout::NewsArticleBox.new(#{h}) do
          news_image({:image_path=>"#{Rails.root}/public/1/opinion/홍길동.pdf", :column=>1, :row=>1, :extra_height_in_lines=>5, :stroke_width=>0, :position=>1, :is_float=>true, :fit_type=>4, :before_title=>true, :layout_expand=>nil})
        end
      EOF
    else
      content = <<~EOF
        RLayout::NewsArticleBox.new(#{h})
      EOF
    end
  end

  def save_layout
    File.open(layout_path, 'w') { |f| f.write layout_rb }
  end

  def save_story
    dir_path = File.dirname(story_path)
    FileUtils.mkdir_p(dir_path) unless File.exist?(dir_path)
    File.open(story_path, 'w') { |f| f.write story_md }
  end

  def read_story
    File.open(story_path, 'r', &:read)
  end

  def library_images
    publication.library_images
  end

  def page_columns
    section.column
  end

  def filler_text(empty_line_count, options = {})
    with_reporter = options.fetch(:with_reporter, true)
    filler_text_path = publication.path + "/filler_text/#{page_columns}/#{empty_line_count}_lines_with_reporter.md"
    unless with_reporter
      filler_text_path = publication.path + "/filler_text/#{page_columns}/#{empty_line_count}_lines.md"
    end
    return File.open(filler_text_path, 'r', &:read) + "\n" if File.exist?(filler_text_path)

    ''
  end

  def fill_up_enpty_lines
    # code
    article_info_hash = article_info
    unless article_info_hash
      puts "No article_info found in #{path}!!!!!"
      return
    end
    empty_lines = article_info_hash[:empty_lines]
    return if empty_lines < 0

    if article_info_hash[:empty_lines] > 7
      multiples = empty_lines / 7
      remainder_lines = empty_lines % 7
      text = body
      multiples.times do
        text += filler_text(7, with_reporter: false)
      end
      # remainder_lines
      text += filler_text(remainder_lines)
      self.body = text
    else
      self.body += filler_text(empty_lines)
    end
    save
    generate_pdf
  end

  def make_profile
    profile = "#{page_columns}단 편집_"
    profile += if is_front_page
                 '1면_'
               else
                 '내지_'
               end
    profile += if top_story
                 '메인기사'
               elsif top_position
                 '상단기사'
               else
                 '일반기사'
               end
    profile += "_#{column}x#{row}"

    profile
  end

  def grid_rect
    [grid_x, grid_y, column, row]
  end

  private

  def init_atts
    self.path = section.path + "/#{order}"
    self.publication_name = publication.name
    self.grid_width       = publication.grid_width(page_columns)
    self.grid_height      = publication.grid_height
    self.gutter           = publication.gutter
    self.on_left_edge     = on_left_edge
    self.page_heading_margin_in_lines = section.page_heading_margin_in_lines
    if on_left_edge.nil?
      self.on_left_edge = false
      self.on_left_edge = true if grid_x == 0
    end
    self.on_right_edge = on_right_edge
    if on_right_edge.nil?
      self.on_right_edge = false
      self.on_right_edge = true if (column + grid_x) == section.column
    end
  end
end
