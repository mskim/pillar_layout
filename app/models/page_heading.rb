# == Schema Information
#
# Table name: page_headings
#
#  id           :integer          not null, primary key
#  page_number  :integer
#  section_name :string
#  date         :string
#  layout       :text
#  page_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PageHeading < ApplicationRecord
  belongs_to :page
  has_many :heading_ad_images
  after_create :setup
  # has_one :heading_bg_image
  # accepts_nested_attributes_for :heading_bg_image

  SECTIONS = [
    '1면',
    '정치',
    '정치',
    '정치',
    '자치행정',
    '자치행정',
    '전면광고',
    '국제통일',
    '전면광고',
    '금융',
    '전면광고',
    '금융',
    '금융',
    '산업',
    '산업',
    '산업',
    '산업',
    '정책',
    '정책',
    '기획',
    '기획',
    '오피니언',
    '오피니언',
    '전면광고'
  ]

  def path
    p = page.path
    p += "/heading"
  end

  def issue
    page.issue
  end

  def publication
    issue.publication
  end

  def relative_path
    page.relative_path + "/heading"
  end
  
  def setup
    system("mkdir -p #{path}") unless File.directory?(path)
    system("mkdir -p #{images_path}") unless File.directory?(images_path)
    copy_page_heading_template
    generate_pdf
  end

  def copy_page_heading_template
    system("cp -r #{page_heading_bg_image_folder}/* #{images_path}/")
    images_path
  end
  
  def page_heading_bg_image_folder
    publication.path + "/page_heading/#{page_number}/images"
  end
  

  def images_path
    path + "/images"
  end

  def layout_path
    path + "/layout.rb"
  end

  def pdf_path
    path + "/output.pdf"
  end

  def background_pdf_path
    path + "/images/1_bg.pdf"
  end

  def jpg_path
    path + "/output.jpg"
  end

  def pdf_image_path
    relative_path + "/output.pdf"
  end

  def jpg_image_path
    relative_path + "/output.jpg"
  end

  def grid_x
    0
  end

  def grid_y
    0
  end

  def page_heading_width
    publication.page_heading_width
  end

  def width
    page_heading_width
  end

  def heading_height
    if page_number == 1
      publication.front_page_heading_height_in_pt
    elsif page_number == 21 || page_number == 22 || page_number == 23
      publication.opinion_page_heading_height_in_pt
    else
      publication.inner_page_heading_height_in_pt
    end
  end

  def height
    heading_height
  end

  def box_svg
    "<a xlink:href='/page_headings/#{id}'><rect fill-opacity='0.0' x='#{0}' y='#{0}' width='#{page_heading_width}' height='#{heading_height}' /></a>\n"
  end

  def box_svg_for_section
    "<rect fill-opacity='0.0' x='#{0}' y='#{0}' width='#{page_heading_width}' height='#{heading_height}' />\n"
  end

  def background_image_full_path
    path + "/images/1_bg.pdf"
  end

  def odd_page_image_full_path
    path + "/images/odd.pdf"
  end

  def even_page_image_full_path
    path + "/images/even.pdf"
  end

  def heading_ad_full_path
    path + "/images/heading_ad.pdf"
  end

  def p21_page_image_full_path
    path + "/images/21_bg.pdf"
  end

  def p22_page_image_full_path
    path + "/images/22_bg.pdf"
  end

  def p23_page_image_full_path
    path + "/images/23_bg.pdf"
  end

  def front_page_content
    page_heading_width  = publication.page_heading_width
    first_page=<<~EOF
    RLayout::Container.new(width: #{page_heading_width}, height: #{publication.front_page_heading_height_in_pt}, layout_direction: 'horinoztal') do
      image(image_path: '#{background_image_full_path}', x:0, y:0, width: #{page_heading_width}, height: 139.0326207874)
      text('#{page.korean_date_string}', x: 828.00, y: 107.25, fill_color:'clear', width: 200, font: 'KoPubDotumPL', font_size: 9.5, font_color: "CMYK=0,0,0,100", text_alignment: 'right')
      image(image_path: '#{heading_ad_full_path}', x:809.137, y:13.043, width: 219.257, height: 71.2)
    end
  EOF
  end

  def odd_content
    page_heading_width  = publication.page_heading_width
    page_heading_height = publication.inner_page_heading_height_in_pt
    # date                = '2017년 5월 11일 목요일'
    date                = page.korean_date_string #'2017년 5월 11일 목요일'
    page_number         = page.page_number
    section_name        = page.display_name || page.section_name
    section_width       = 400
    section_x           = 1028.9763779528/2 - section_width/2
    section_name_with_space        = put_space_between_chars(section_name)

    odd=<<~EOF
    RLayout::Container.new(width: 1028.9763779528, height: 41.70978623622, layout_direction: 'horinoztal') do
      image(image_path: '#{odd_page_image_full_path}', width: 1028.9763779528, height: 41.70978623622, fit_type: 0)
      t = text('<%= section_name_with_space %>', font_size: 20.5,x: <%= section_x %>, y: 0.5, width: <%= section_width %>, font: 'KoPubBatangPM', text_color: "CMYK=0,0,0,100", fill_color:'clear', text_fit_type: 'fit_box_to_text', text_alignment: 'center')
      line(x: t.x, y:27.6, width: t.width, stroke_width: 2, height:0, storke_color:"CMYK=0,0,0,100")
      text('<%= date %>', tracking: -0.7, x: 779.213, y: 12.16,  width: 200, font: 'KoPubDotumPL', font_size: 10.5, text_color: "CMYK=0,0,0,100", text_alignment: 'right', fill_color:'clear')
      text('<%= page_number %>', tracking: -0.2, x: 974.69, y: -6.47, font: 'KoPubDotumPL', font_size: 36, text_color: "CMYK=0,0,0,100", width: 50, height: 44, fill_color:'clear', text_alignment: 'right')
    end
  EOF
    page_heading_erb = ERB.new(odd)
    page_heading_erb.result(binding)
  end


  def even_content
    page_heading_width  = publication.page_heading_width
    page_heading_height = publication.inner_page_heading_height_in_pt
    date                = page.korean_date_string #'2017년 5월 11일 목요일'
    page_number         = page.page_number
    section_name        = page.display_name || page.section_name
    section_width       = 400
    section_x           = 1028.9763779528/2 - section_width/2
    section_name_with_space        = put_space_between_chars(section_name)
    even=<<~EOF
    RLayout::Container.new(width: 1028.9763779528, height: 41.70978623622, layout_direction: 'horinoztal') do
      image(image_path: '#{even_page_image_full_path}', x: 0, y: 0, width: 1028.9763779528, height: 41.70978623622, fit_type: 0)
      t = text('<%= section_name_with_space %>', font_size: 20.5, x: <%= section_x %>, y: 0.5, width: <%= section_width %>, font: 'KoPubBatangPM', text_color: "CMYK=0,0,0,100", fill_color:'clear', text_fit_type: 'fit_box_to_text', text_alignment: 'center')
      line(x: t.x, y:27.6, width: t.width, stroke_width: 2, height:0, storke_color:"CMYK=0,0,0,100")
      text('<%= page_number %>', tracking: -0.2, x: 0, y: -6.47, font: 'KoPubDotumPL', font_size: 36, text_color: "CMYK=0,0,0,100", width: 50, height: 44, fill_color: 'clear')
      text('<%= date %>', tracking: -0.7, x: 50, y: 12.16, width: 200, font: 'KoPubDotumPL', font_size: 10.5, text_color: "CMYK=0,0,0,100", text_alignment: 'left', fill_color: 'clear')
    end
    EOF
    page_heading_erb = ERB.new(even)
    page_heading_erb.result(binding)
  end

  def p21_content
    page_heading_width  = publication.page_heading_width
    page_heading_height = publication.opinion_page_heading_height_in_pt
    date                = page.korean_date_string #'2017년 5월 11일 목요일'
    page_number         = page.page_number
    section_name        = page.display_name || page.section_name
    section_name_with_space        = put_space_between_chars(section_name)
    template=<<~EOF
    RLayout::Container.new(width: 1028.9763779528, height: 55.613048314961, layout_direction: 'horinoztal') do
      image(image_path: '#{p21_page_image_full_path}', x: 0, y: 0, width: 1028.9763779528, height: 55.613048314961, fit_type: 0)
      text('<%= date %>', x: 50.5693, y: 8.88,  width: 200, height: 12, font: 'KoPubDotumPL', text_color: "CMYK=0,0,0,100", tracking: -0.7, font_size: 10.5, text_alignment: 'left')
      text('21', x: 988.81, y: -4.97, tracking: -0.2, text_alignment: 'center', fill_color: 'clear', font: 'KoPubDotumPL', font_size: 36, text_color: "CMYK=0,0,0,100", width: 40, height: 44)
    end
    EOF
    page_heading_erb = ERB.new(template)
    page_heading_erb.result(binding)
  end

  def p22_content
    page_heading_width  = publication.page_heading_width
    page_heading_height = publication.opinion_page_heading_height_in_pt
    date                = page.korean_date_string #'2017년 5월 11일 목요일'
    page_number         = page.page_number
    section_name        = page.section_name
    section_name_with_space        = put_space_between_chars(section_name)
    template=<<~EOF
    RLayout::Container.new(width: 1028.9763779528, height: 55.613048314961, layout_direction: 'horinoztal') do
      image(image_path: '#{p22_page_image_full_path}' , x: 0, y: 0, width: 1028.9763779528, height: 55.613048314961, fit_type: 0)
      text('<%= date %>', x: 864.104, y: 8.88, fill_color: 'clear', tracking: -0.7, width: 110, height: 12, font: 'KoPubDotumPL', text_color: "CMYK=0,0,0,100", font_size: 10.5, text_alignment: 'right')
      text('22', tracking: -0.2, x: 0, y: -4.97, text_alignment: 'center', fill_color: 'clear', font: 'KoPubDotumPL', font_size: 36, text_color: "CMYK=0,0,0,100", width: 40, height: 44)
    end
    EOF
    page_heading_erb = ERB.new(template)
    page_heading_erb.result(binding)
  end

  def p23_content
    page_heading_width  = publication.page_heading_width
    page_heading_height = publication.opinion_page_heading_height_in_pt
    date                = page.korean_date_string #'2017년 5월 11일 목요일'
    page_number         = page.page_number
    section_name        = page.display_name || page.section_name
    section_name_with_space        = put_space_between_chars(section_name)
    template=<<~EOF
    RLayout::Container.new(width: 1028.9763779528, height: 55.613048314961, layout_direction: 'horinoztal') do
      image(image_path: '#{p23_page_image_full_path}', x: 0, y: 0, width: 1028.9763779528, height: 55.613048314961, fit_type: 0)
      text('<%= date %>', x: 50.5693, y: 8.88,  width: 200, height: 12, font: 'KoPubDotumPL', text_color: "CMYK=0,0,0,100", tracking: -0.7, font_size: 10.5, text_alignment: 'left')
      text('23', x: 988.81, y: -4.97, tracking: -0.2, text_alignment: 'center', fill_color: 'clear', font: 'KoPubDotumPL', font_size: 36, text_color: "CMYK=0,0,0,100", width: 40, height: 44)
    end
    EOF
    page_heading_erb = ERB.new(template)
    page_heading_erb.result(binding)
  end

  def put_space_between_chars(string)
    return string if string.include?(" ")
    string.split("").join(" ")
  end

  def layout_content
    if page_number == 1
      return front_page_content
    elsif page_number == 21
      return p21_content
    elsif page_number == 22
      return p22_content
    elsif page_number == 23
      return p23_content
    elsif page_number.even?
      return even_content
    else
      return odd_content
    end
  end

  def save_layout
    File.open(layout_path, 'w'){|f| f.write layout_content}
  end

  def generate_pdf
    save_layout
    page_heading_object = eval(layout_content)
    page_heading_object.save_pdf_with_ruby(pdf_path)
  end

end
