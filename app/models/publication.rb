# == Schema Information
#
# Table name: publications
#
#  id                             :integer          not null, primary key
#  article_bottom_spaces_in_lines :integer
#  article_line_draw_sides        :text
#  article_line_thickness         :float
#  bottom_margin                  :float
#  bottom_margin_in_unit          :float
#  cms_server_url                 :string
#  draw_divider                   :boolean
#  front_page_heading_height      :integer
#  gutter                         :float
#  gutter_in_unit                 :float
#  height                         :float
#  height_in_unit                 :float
#  inner_page_heading_height      :integer
#  left_margin                    :float
#  left_margin_in_unit            :float
#  lines_per_grid                 :integer
#  name                           :string
#  page_columns                   :text
#  page_count                     :integer
#  paper_size                     :string
#  right_margin                   :float
#  right_margin_in_unit           :float
#  row                            :integer
#  section_names                  :text
#  top_margin                     :float
#  top_margin_in_unit             :float
#  unit                           :string
#  variable_page_count            :boolean
#  width                          :float
#  width_in_unit                  :float
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

# front_page_heading_height: height of frontpage heading in lines
# inner_page_heading_height: height of innerpage heading in lines
# page_heading_margin_in_lines: actual heading margin for top positined article
# 393 mm
# 1114.0157480315 pt
# 545 mm
# 1544.8818897638 pt
# 15mm  marging
# 42.51968503937
#
# 1 mm = 2.8346456692913 point; 1 point = 0.35277777777778 mm

# 1 in = 72 point; 1 point = 0.013888888888889 in
# 1 px = 0.75 point; 1 point = 1.3333333333333 px
PAGES_WITH_4_LINE_HEADING = [22,23]

class Publication < ApplicationRecord
  has_many :issues
  has_many :heading_bg_images

  after_create :setup
  before_save :convert_to_pt

  MM2POINT    = 2.8346456692913
  INCH2POINT  = 72
  PX2POINT    = 0.75
  SECTIONS = [
    '1면',
    '정치',
    '자치행정',
    '국제통일',
    '금융',
    '산업',
    '정책',
    '기획',
    '오피니언',
    '글로벌포커스',
  ]

  def path
    "#{Rails.root}/public/#{id}"
  end

  def url
    "/#{id}"
  end

  def images_path
    "#{Rails.root}/public/images"
  end

  def first_page_bg_image_path
    "#{Rails.root}/public/#{id}/page_heading/1/images/1_bg.pdf"
  end

  def sections
    SECTIONS
  end

  def library_images
    path_array = Dir.glob("#{images_path}/*[.jpg,.pdf]")
    front = "#{Rails.root}/public"
    path_array.map{|p| p.gsub!(front, "")}
  end

  def text_style_info_path
    publication_info_folder + "/text_style.yml"
  end

  def copy_text_style_to_shared_location
    text_style_source = path + "/text_style/text_style.yml"
    system("cp #{text_style_source} #{text_style_info_path}")
  end

  def setup
    system "mkdir -p #{path}" unless File.directory?(path)
  end

  def publication_info_folder
    "/Users/Shared/SoftwareLab/newsman/#{name}"
  end

  def info_yml_path
    publication_info_folder + "/publication_info.yml"
  end

  def publication_info_hash
    info_hash = attributes.dup
    info_hash.shift  # delete id
    info_hash.delete('created_at')    # delete
    info_hash.delete('updated_at')    # delete
    info_hash
  end

  def heading_path
    path + "/page_heading"
  end

  def save_publication_info
    system("mkdir -p #{publication_info_folder}") unless File.directory?(publication_info_folder)
    File.open(info_yml_path,'w'){|f| f.write publication_info_hash.to_yaml}
  end

  def self.holidays
    holidays_path = "#{Rails.root}/public/1/holidays.yml"
    holidays = File.open(holidays_path, 'r'){|f| f.read}
    holidays_array = YAML::load(holidays)
    holidays_array.map{|d| d.to_s}
  end

  def grid_width(page_columns)
    (width - left_margin - right_margin)/page_columns
  end

  def column_width(page_columns)
    grid_width(page_columns) - gutter
  end

  def grid_height
    (height - top_margin - bottom_margin)/row
  end

  def body_line_height
    grid_height/lines_per_grid
  end

  def body_line_height_in_mm
    (body_line_height/MM2POINT).round(2)
  end

  def front_page_heading_margin
    front_page_heading_height - lines_per_grid
  end

  def x_of_grid_frame(page_columns, grid_frame)
    left_margin + grid_width(page_columns)*grid_frame[0]
  end

  def y_of_grid_frame(page_columns, grid_frame)
    grid_frame[1]*grid_height
  end

  def width_of_grid_frame(page_columns, grid_frame)
    grid_width(page_columns)*grid_frame[2]
  end

  def height_of_grid_frame(page_columns, grid_frame)
    grid_frame[3]*grid_height
  end

  def frame_rect_of_grid_frame(page_columns, grid_frame)
    [x_of_grid_frame(grid_frame), y_of_grid_frame(grid_frame), width_of_grid_frame(grid_frame), height_of_grid_frame(grid_frame)]
  end

  def page_width
    width - left_margin - right_margin
  end

  def spread_width
    width*2 - left_margin - right_margin
  end

  def page_heading_width
    page_width
  end

  def page_height
    height - top_margin - bottom_margin
  end

  def page_heading_width_in_mm
    (page_heading_width/MM2POINT).round(2)
  end

  def reload_section_names
    section_names_path = path + "/section_names.rb"
    self.section_names = File.open(section_names_path, 'r'){|f| f.read}
    self.save
  end

  def mm2pt(value)
    value*MM2POINT
  end

  def self.mm2pt(value)
    value*MM2POINT
  end

  def inch2pt(value)
    value*INCH2POINT
  end

  def self.inch2pt(value)
    value*INCH2POINT
  end

  def self.px2pt(value)
    value*PX2POINT
  end

  def convert_to_pt
    if unit == 'mm'
      self.width          = mm2pt(width_in_unit)
      self.height         = mm2pt(height_in_unit)
      self.left_margin    = mm2pt(left_margin_in_unit)
      self.top_margin     = mm2pt(top_margin_in_unit)
      self.right_margin   = mm2pt(right_margin_in_unit)
      self.bottom_margin  = mm2pt(bottom_margin_in_unit)
      self.gutter         = mm2pt(gutter_in_unit)
    elsif unit == 'inch'
      self.width          = inch2pt(width)
      self.height         = inch2pt(height)
      self.left_margin    = inch2pt(left_margin)
      self.top_margin     = inch2pt(top_margin)
      self.right_margin   = inch2pt(right_margin)
      self.bottom_margin  = inch2pt(bottom_margin)
    end
  end

  def page_heading_margin_in_lines(page_number)
    case page_number
    when 1
      front_page_heading_margin
    when 18, 19, 21, 22,23
      inner_page_heading_height + 1
    else
      inner_page_heading_height
    end
  end

  def front_page_heading_height_in_pt
    front_page_heading_height*body_line_height
  end

  def inner_page_heading_height_in_pt
    inner_page_heading_height*body_line_height
  end

  def opinion_page_heading_height_in_pt
    (inner_page_heading_height + 1)*body_line_height
  end

  def layout_rb
    h = {}
    h[:width]       = width
    h[:height]      = height
    h[:left_margin] = left_margin
    h[:top_margin]  = top_margin
    h[:right_margin]= right_margin
    h[:bottom_margin]= bottom_margin
    h[:stroke_width] = 0.5
    columns = eval(page_columns)
    if columns.class == Array
      columns = columns.last
    elsif columns.class == Fixnum
      columns = columns
    end
    column_width = (page_heading_width - (columns - 1)*gutter)/columns

    content=<<~EOF
    RLayout::Container.new(#{h}) do
      rectangle(x: #{left_margin}, y: #{top_margin}, width: #{page_heading_width}, height: #{front_page_heading_height_in_pt}, fill_color: 'lightGray')
      rectangle(x: #{left_margin}, y: #{top_margin}, width: #{page_heading_width}, height: #{opinion_page_heading_height_in_pt}, fill_color: 'gray')
      rectangle(x: #{left_margin}, y: #{top_margin}, width: #{page_heading_width}, height: #{inner_page_heading_height_in_pt}, fill_color: 'darkGray')

      x_position = #{left_margin}
      #{columns}.times do
        rectangle(x: x_position, y: #{top_margin}, width: #{column_width}, height: #{page_height}, stroke_width: 0.5, fill_color: 'clear')
        x_position += #{column_width} + #{gutter}
      end
      y = #{top_margin}
      #{row }.times do |i|
        line(x: #{left_margin}, y: y , width: #{page_heading_width}, height: 0, #{}stroke_width: 0.6, stroke_color: 'red', fill_color: 'clear')
        line_top = y
        #{lines_per_grid}.times do |j|
          line(x: #{left_margin}, y: line_top , width: #{page_heading_width}, height: 0, #{}stroke_width: 0.1, stroke_color: 'red', fill_color: 'clear')
          line_top += #{body_line_height}
        end
        y += #{grid_height}
      end
    end
    EOF

  end
  # #{raw - 2}.times do |i|
  #   line([#{left_margin}, #{(i + 1)*grid_height}], [#{left_margin + page_heading_width}, #{(i + 1)*grid_height}])
  # end

  def sample_page_path
    path + "/sample"
  end

  def sample_page_layout_path
    sample_page_path + "/layout.rb"
  end

  def pdf_path
    sample_page_path + "/output.pdf"
  end

  def pdf_image_path
    "/#{id}/sample/output.pdf"
  end

  def save_sample_page_layout_rb
    system("mkdir -p #{sample_page_path}") unless File.directory?(sample_page_path)
    File.open(sample_page_layout_path, 'w'){|f| f.write layout_rb}
  end

  def generate_sample_pdf
    save_sample_page_layout_rb
    system "cd #{sample_page_path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end

  def main_server_info
    h = {}
    h[:ip] = ""
    h[:user] = ""
    h[:password] = ""
    h
  end
end
