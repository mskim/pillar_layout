# == Schema Information
#
# Table name: ad_boxes
#
#  id                           :integer          not null, primary key
#  grid_x                       :integer
#  grid_y                       :integer
#  column                       :integer
#  row                          :integer
#  order                        :integer
#  ad_type                      :string
#  advertiser                   :string
#  inactive                     :boolean
#  ad_image                     :string
#  page_id                      :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  color                        :boolean
#  path                         :string
#  date                         :date
#  page_heading_margin_in_lines :integer
#  page_number                  :integer
#  grid_width                   :float
#  grid_height                  :float
#  gutter                       :float
#
# Indexes
#
#  index_ad_boxes_on_page_id  (page_id)
#

class AdBox < ApplicationRecord
  belongs_to :page
  belongs_to :spread, optional: true
  mount_uploader :ad_image, AdImageUploader
  has_one_attached :storage_ad_image
  before_create :init_atts
  after_create :setup
  include StorageBackupWorkingArticle
  
  def path
    page.path + "/ad"
  end

  def url
    path.sub("#{Rails.root}/public}", "")
  end

  def image_path
    if storage_ad_image.attached?
      ActiveStorage::Blob.service.send(:path_for, storage_ad_image.key)
    end
  end

  def image_ext
    File.extname(storage_ad_image.blob[:filename])
  end

  def issue
    page.issue
  end

  def latest_pdf_basename
    f = Dir.glob("#{path}/output*.pdf").sort.last
    File.basename(f) if f
  end

  def latest_jpg_basename
    f = Dir.glob("#{path}/output*.jpg").sort.last
    File.basename(f) if f
  end

  def pdf_image_path
    # "/1/issue/#{page.issue.date}/#{page.page_number}/ad/#{latest_jpg_basename}"
    "/1/issue/#{date}/#{page_number}/ad/#{latest_pdf_basename}"
  end

  def jpg_image_path
     "/1/issue/#{date}/#{page_number}/ad/#{latest_jpg_basename}"
  end

  def jpg_path
    path + "/output.jpg"
  end

  def pdf_path
    path + "/output.pdf"
  end

  def publication
    if page
      page.publication
    else
      #TODO
      Publication.first
    end
  end

  def width
    grid_width*column
  end

  # def grid_height
  #   publication.grid_height
  # end

  def height
    if top_position?
      grid_height*row - page_heading_margin_in_lines*page.body_line_height
    else
      grid_height*row
    end
  end

  def x
    grid_width*grid_x
  end

  def y
    if top_position?
      grid_height*grid_y + page_heading_margin_in_lines*page.body_line_height
    else
      grid_height*grid_y
    end
  end

  def ad_height
    if top_position?
      grid_height*row - page_heading_margin_in_lines*page.body_line_height
    else
      grid_height*row
    end
  end

  def ad_box_rect
    [x,y,width,height]
  end

  def top_position?
    grid_y == 0 || (grid_y == 1 && page_number == 1)
  end

  def on_left_edge?
    grid_x == 0
  end

  def on_right_edge?
    if column == 6 || column == 7
      true
    else
      grid_x + column >= page.column 
    end
  end

  def is_front_page?
    page_number == 1
  end

  def layout_rb
    x             = publication.left_margin
    left_inset    = 0
    right_inset   = 0
    ad_width      = grid_width*column
    if page_number.odd?
      x = publication.width - publication.right_margin - ad_width
      if column < page.column
        x += gutter/2
        ad_width -= gutter
        left_inset = gutter
      end
    else
      if column < page.column
        ad_width -= gutter
        right_inset = gutter
      end
    end
    page_heading_margin_in_lines = 0
    if top_position?
      if is_front_page?
        # front_page_heading_height - lines_per_grid
        page_heading_margin_in_lines = publication.front_page_heading_margin
      else
        page_heading_margin_in_lines = publication.inner_page_heading_height
      end
    end

    ad_image_hash = {}
    ad_image_hash[:layout_expand]                  = [:width, :height]
    ad_image_hash[:page_heading_margin_in_lines]   = page_heading_margin_in_lines
    content=<<~EOF
    RLayout::NewsAdBox.new(is_ad_box: true, column: #{column}, row: #{row}, grid_width: #{grid_width}, grid_height: #{grid_height}, on_left_edge: #{on_left_edge?}, on_right_edge: #{on_right_edge?}, top_position: #{top_position?}, page_heading_margin_in_lines: #{page_heading_margin_in_lines}, :article_line_draw_sides=>"[0, 0, 0, 0]") do
      image(image_path: '#{image_path}', fit_type: 4, layout_expand: [:width, :height])
      relayout!
    end
    EOF
  end

  def layout_path
    path + "/layout.rb"
  end

  def save_layout
    File.open(layout_path, 'w'){|f| f.write layout_rb}
  end

  def stamp_time
    t = Time.now
    h = t.hour
    @time_stamp = "#{t.day.to_s.rjust(2,'0')}#{t.hour.to_s.rjust(2,'0')}#{t.min.to_s.rjust(2,'0')}#{t.sec.to_s.rjust(2,'0')}"
  end

  def delete_old_files
    old_pdf_files = Dir.glob("#{path}/output*.pdf")
    old_jpg_files = Dir.glob("#{path}/output*.jpg")
    old_pdf_files += old_jpg_files
    old_pdf_files.each do |old|
      system("rm #{old}")
    end
  end

  def generate_pdf_with_time_stamp
    delete_old_files
    stamp_time
    save_ad_box_pdf
  end

  def make_ad_box_path
    FileUtils.mkdir_p(path) unless File.exist?(path)
  end

  def save_ad_box_pdf(options={})
    make_ad_box_path
    save_hash                     = {}
    save_hash[:article_path]      = path
    save_hash[:layout_rb]         = layout_rb
    save_layout
    new_box_marker                = RLayout::NewsBoxMaker.new(save_hash)
  end

  def box_svg
    # s =  "<line stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{grid_width*column}' height='#{ad_height}' />"
    # s =  "<line stroke='black' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{grid_width*column}' height='#{ad_height}' />"
    s = "<a xlink:href='/ad_boxes/#{id}'><rect stroke='gray' stroke-width='0' fill-opacity='0.0' x='#{x}' y='#{y}' width='#{grid_width*column}' height='#{ad_height}' /></a>\n"
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

  def mobile_preview_xml_article_info
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    page_info        = page_number.to_s.rjust(2,"0")

    @group_key        = "#{year}#{month}#{day}.011001#{page_info}00000#{@order}"
    @cms_file_name    = "#{year}#{month}#{day}00100#{page_info}#{@order}"
    @article_file_name = "#{year}#{month}#{day}011001#{page_info}00000000#{@order}"
    @name        = "편집기자명" # 편집기자명
    @news_class_large_id    = news_class_large_id
    @news_class_large_name  = page.section_name
    @news_class_middle_id   = ""
    @news_class_middle_name = ""
    @send_modify            = "0"  # 수정횟수
    @new_article            = "0" #뭘까?
    @photo_file_name        = "#{year}#{month}#{day}.011001#{page_info}00000#{@order}.01L.jpg"
    #해당기사 저자사진: 121 × 160 픽셀, 120 픽셀/인치
    #해당기사 그래픽은 .01L대신 .01S.jpg로 표시

      article_info =<<EOF
      <ArticleInfo>
        <GroupKey><%= @group_key %></GroupKey>
        <CmsFileName><%= @cms_file_name %></CmsFileName>
        <CmsRelationName/>
        <ArticleFileName><%= @article_file_name %>.txt</ArticleFileName>
        <GisaNumberID/>
        <GisaRelationID/>
        <ByLine/>
        <Gija ID="0" Area="0" Name="<%= @name %>" Email=""/>
        <NewsClass LargeID="<%= @news_class_large_id %>" LargeName="<%= @news_class_large_name %>" MiddleID="<%= @news_class_middle_id %>" MiddleName="<%= @news_class_middle_name %>"/>
        <SendModify><%= @send_modify %></SendModify>
        <NewArticle><%= @new_article %></NewArticle>
      </ArticleInfo>
EOF
          article = ""

          erb = ERB.new(article_info)
          article += erb.result(binding)
  end


  def mobile_preview_xml_component
    @name_plate      = '광고'
      if page.section_name == "전면광고"
        @name_plate      = '전면광고'
      end
    @head_line    = advertiser
    @head_line    = @head_line.gsub("\&", "&amp;")

    three_component =<<EOF
      <TitleComponent>
        <MainTitle>[<%= @name_plate %>] <%= @head_line %></MainTitle>
        <% if @sub_head_line == nil && @sub_head_line == "" %><% else %>
        <SubTitle><![CDATA[<%= @sub_head_line %>]]></SubTitle><% end %>
      </TitleComponent>
      <ArticleComponent>
        <Content><![CDATA[<!--[[--image1--]]//--><%= @data_content %><%= @by_line %>]]></Content>
      </ArticleComponent>
  </Article>
EOF
    component = ""

    erb = ERB.new(three_component)
    component += erb.result(binding)
  end

  def xml_group_key_template
        # @head_line2        = @head_line1.gsub("\u201D", "&quot;")
        year  = issue.date.year
        month = issue.date.month.to_s.rjust(2, "0")
        day   = issue.date.day.to_s.rjust(2, "0")
        page_info        = page_number.to_s.rjust(2,"0")
        @order = page.working_articles.length + 1
        @group_key        = "#{year}#{month}#{day}.011001#{page_info}00000#{@order}"

        @name_plate   = '광고'
         if page.section_name == '전면광고'
          @name_plate = '전면광고'
         end
        @head_line    = advertiser
        @head_line    = @head_line.gsub("\&", "&amp;")

      container_xml_group_key=<<EOF
      <Group Key="<%= @group_key %>" CmsFileName="" Title="<%= "[#{@name_plate}] " if @name_plate && @name_plate !="" %><%= @head_line %>"/>
EOF
      xml_group_key = ""
      erb = ERB.new(container_xml_group_key)
      xml_group_key += erb.result(binding)
  end


  def ad_xml
    story_erb_path = "#{Rails.root}/public/1/newsml/ad_box_xml.erb"
    story_xml_template = File.open(story_erb_path, 'r'){|f| f.read}
    year  = issue.date.year
    month = issue.date.month.to_s.rjust(2, "0")
    day   = issue.date.day.to_s.rjust(2, "0")
    hour  = updated_at.hour.to_s.rjust(2, "0")
    min   = updated_at.min.to_s.rjust(2, "0")
    sec   = updated_at.sec.to_s.rjust(2, "0")
    page_info        = page_number.to_s.rjust(2,"0")
    updated_date      = "#{year}#{month}#{day}"
    # updated_time      = "#{hour}#{min}#{sec}+0900"
    updated_time      = "100000+0900"
    @date_and_time    = "#{updated_date}T#{updated_time}"
    @date_id          = updated_date
    @news_key_id      = "#{updated_date}.011001#{page_info}0000#{two_digit_ord}"
    @day_info         = "#{year}년#{month}월#{day}일"
    @media_info       = publication.name
    # @edition_info     = page_number.to_s.rjust(2,"0")
    # @page_info        = publication.paper_size
    @page_info        = page_number.to_s.rjust(2,"0")
    @jeho_info        = issue.number

    @news_title_info = '광고'
    if page.section_name == "전면광고"
      @name_plate = '전면광고'
    else
      @name_plate = '광고' 
    end
    @section_name_code = section_name_code

    @gisa_key         = "#{@date_id}991#{@page_info}#{two_digit_ord}"
    @money_status     = "0"
    @head_line        = advertiser


    story_erb = ERB.new(story_xml_template)
    story_erb.result(binding)
    story_erb = ERB.new(story_xml_template)
    story_erb.result(binding)
  end

  def newsml_issue_path
    "#{Rails.root}/public/1/issue/#{issue.date}/newsml"
  end

  def two_digit_ord
    return "01" if page.section_name == "전면광고"
    order.to_s.rjust(2, "0")
  end

  def  ad_two_digit_ord
    return "01" if page.section_name == "전면광고"
    order.to_s.rjust(2, "0")
  end

  def save_ad_xml
    FileUtils.mkdir_p(newsml_issue_path) unless File.exist? newsml_issue_path
    ad_xml_path = "#{newsml_issue_path}/#{ad_xml_filename}"
    File.open(ad_xml_path, 'w:euc-kr'){|f| f.write ad_xml}
  end

  def ad_xml_filename
    date_without_minus = issue.date.to_s.gsub("-","")
    two_digit_page_number = page_number.to_s.rjust(2, "0")
    two_digit = ad_two_digit_ord
    two_digit = "01" if page.section_name == "전면광고"
    "#{date_without_minus}.011001#{two_digit_page_number}0000#{two_digit}.xml"
  end

  def publication
    page.publication
  end

  def change_ad_box_layout(new_ad_type, column)
    info = {}
    case new_ad_type
    when '15단통'
      self.grid_x = 0
      self.grid_y = 0
      self.column = column
      self.row    = 15
    when '5단통'
      self.grid_x = 0
      self.grid_y = 10
      self.column = column
      self.row    = 5
    when '4단통'
      self.grid_x = 0
      self.grid_y = 11
      self.column = column
      self.row    = 4
    when '3단통'
      self.grid_x = 0
      self.grid_y = 12
      self.column = column
      self.row    = 3
    when '9단21'
      if page_number.odd?
        self.grid_x = 3
        self.grid_y = 6
        self.column = 4
        self.row    = 9
      else
        self.grid_x = 0
        self.grid_y = 6
        self.column = 4
        self.row    = 9
      end
    when '9단21_홀'
      self.grid_x = 3
      self.grid_y = 6
      self.column = 4
      self.row    = 9
    when '9단21_짝'
      self.grid_x = 0
      self.grid_y = 6
      self.column = 4
      self.row    = 9
    when '7단15'
      if page_number.odd?
        self.grid_x = 4
        self.grid_y = 8
        self.column = 3
        self.row    = 7
      else
        self.grid_x = 0
        self.grid_y = 8
        self.column = 3
        self.row    = 7
      end
    when '7단15_홀'
      self.grid_x = 4
      self.grid_y = 8
      self.column = 3
      self.row    = 7
    when '7단15_짝'
      self.grid_x = 0
      self.grid_y = 8
      self.column = 3
      self.row    = 7
    else
      puts "+++++++++ unsupported ad_type:#{ad_type}"
      return
    end
    self.ad_type = new_ad_type
    self.grid_width = publication.grid_width(column)
    self.save
    generate_pdf_with_time_stamp
  end

  def delete_folder
    system("rm -rf #{path}")
  end

  def profile
    "#{page.column}_#{ad_type}"
  end

  def sample_path
    "#{Rails.root}/public/1/sample/ad_box/#{page.column}/#{ad_type}"
  end
  
  def copy_to_sample
    return if ad_type == "광고없음"
    unless File.exist?(sample_path)
      FileUtils.mkdir_p(sample_path) unless File.exist?(sample_path)
      command = "cp -r #{path}/* #{sample_path}"
      system("#{command}")
    end
  end

  def copy_from_sample
    return if ad_type == "광고없음"
    if File.exist?(pdf_path)
    else
      if File.exist?(sample_path)
        system("cp -r #{sample_path}/* #{path}")
      else
        generate_pdf_with_time_stamp
      end
    end
  end

  def setup
    FileUtils.mkdir_p path unless File.exist?(path)
    copy_from_sample
  end

  private

  def init_atts
    self.path         = page.path + "/ad"
    self.page_number  = page.page_number
    self.grid_width   = publication.grid_width(page.column)
    self.grid_height  = publication.grid_height
    self.gutter       = publication.gutter
    self.page_heading_margin_in_lines = page.page_heading_margin_in_lines
    self.date         = page.issue.date
  end

end