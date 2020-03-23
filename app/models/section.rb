# == Schema Information
#
# Table name: sections
#
#  id                           :integer          not null, primary key
#  ad_type                      :string
#  article_line_thickness       :float
#  bottom_margin                :float
#  color_page                   :boolean          default(FALSE)
#  column                       :integer
#  draw_divider                 :boolean
#  grid_height                  :float
#  grid_width                   :float
#  gutter                       :float
#  height                       :float
#  is_front_page                :boolean
#  layout                       :text
#  left_margin                  :float
#  lines_per_grid               :float
#  order                        :integer
#  page_heading_margin_in_lines :integer
#  page_number                  :integer
#  path                         :string
#  profile                      :string
#  right_margin                 :float
#  row                          :integer
#  section_name                 :string
#  story_count                  :integer
#  top_margin                   :float
#  width                        :float
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  publication_id               :integer          default(1)
#

class Section < ApplicationRecord

  belongs_to :publication, optional: true
  has_many :articles
  has_many :ad_box_templates

  # after_create :setup
  # before_create :parse_profile
  
  include PageSplitable
  include RectUtils

  serialize :layout, Array
  serialize :pillar_layout, Array


  def setup
    system "mkdir -p #{path}" unless File.directory?(path)
    save_section_config_yml
    # calling create_articles give validation error Section must exist!!!
    # so call it in controller create, and update action
    # update_section_layout_if
    # copy_page_heading
  end

  def self.section2pillar(section_data)
      pillar = []
      pillar << section_data[0]
      pillar << section_data[1]
      layout_data  = eval(section_data[4])
      # connvert 5 element ad box array into string
      ad_string = nil
      layout_with_fixed_ad = layout_data.map do |box|
        # support legacy ad format 
        if box.length == 5 && box[4].include?('광고_')
          old_ad = box.pop
          ad_string = old_ad.split("_")[1]

        #elsif box[4].include?('광고_') check with ad_type list
        else
          box
        end
      end
      # group boxes into pillars 
      layout_with_fixed_ad.delete(ad_string) if ad_string
      box_group = layout_with_fixed_ad.group_by{|box| [box[0], box[2]]}
      pillar_layout = []
      box_group.each do |key, value|
        if value.length > 1
          # todo
          # check if there is any hole between the boxes
          # check if boxes has "기사" or "사설"
          pillar_height = value.map{|box| box[3]}.reduce(:+)
          value[0][3] = pillar_height
          value[0] << value.length
          pillar_layout << value[0]
        else
          pillar_layout += value
        end
      end
      pillar_layout << ad_string if ad_string
      pillar << pillar_layout
  end

  def self.fix_ad_names
    Section.all.each do |section|
      next unless Ad.side_ads.include?(section.ad_type)
      section.fix_ad_type
    end
  end

  def need_update?
    section_time = File.birthtime(path)
    articles.each do |article|
      article_time = File.birthtime(article.pdf_path)
      return true if article_time > section_time
    end
    false
  end

  def self.update_section_pdfs
    Section.all.each do |section|
      section.generate_pdf if section.need_update?
    end
  end

  def self.fix_un_finished_sections
    Section.all.each do |section|
      section.update_pdf_section
    end
  end

  def un_finished?
    articles.each do |article|
      return true unless article.has_pdf?
    end
    false
  end

  def fix_ad_type
    return unless Ad.side_ads.include?(ad_type)
    if section.page_number.odd?
      new_ad_type = ad_type + "_홀"
    elsif section.page_number.even?
      new_ad_type = ad_type + "_짝"
    end
    self.ad_type = new_ad_type
    self.profile = make_profile
    self.save
    self
  end

  def self.available_ads_for(page_number)
    ad_type_array = []
    ad_type_array << Section.where(page_number: page_number).all.map{|s| s.ad_type}
    if page_number == 1
    elsif page_number.odd?
      ad_type_array << Section.where(page_number: 101).all.map{|s| s.ad_type}
    else
      ad_type_array << Section.where(page_number: 100).all.map{|s| s.ad_type}
    end
    ad_type_array.flatten.uniq.sort
  end

  def path
    "#{Rails.root}/public/#{publication_id}/section/#{page_number}/#{profile}/#{id}"
  end

  #path from public
  def relative_path
    "/#{publication_id}/section/#{page_number}/#{profile}/#{id}"
  end

  def pdf_image_path
    relative_path + "/section.pdf"
  end

  def pdf_path
    "#{Rails.root}/public/#{publication_id}/section/#{page_number}/#{profile}/#{id}/section.pdf"
  end

  def jpg_image_path
    relative_path + "/section.jpg"
  end

  def jpg_path
    "#{Rails.root}/public/#{publication_id}/section/#{page_number}/#{profile}/#{id}/section.jpg"
  end

  def page_heading_path
    path + "/heading"
  end

  def page_headig_layout_path
    page_heading_path + "/layout.rb"
  end

  def page_heading_width
    width
  end

  def korean_date_string
    if page_number == 1
      "0000년 0월 0일 0요일 (4200호)"
    else
      "0000년 0월 0일 0요일"
    end
  end

   def self.create_section_with(options={})
    if s = Section.where(options).first
      s
    else
      s = Section.where(options).create
    end
  end

  def section_config_hash
    h = {}
    h['section_name']                   = section_name
    h['page_heading_margin_in_lines']   = page_heading_margin_in_lines
    h['ad_type']                        = ad_type || "no_ad"
    h['is_front_page']                  = is_front_page
    h['profile']                        = profile
    h['section_id']                     = id
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
    h['draw_divider']                   = draw_divider
    h
  end


  def bottom_article?(article)
    article_bottom_grid     = article.grid_y + article.row
    article_x_grid          = article.grid_x
    article_y_grid          = article.grid_y
    return true if article_bottom_grid == row
    ad_box = ad_box_templates.first
    return false if ad_box.nil?
    ad_box_x_max_grid       = ad_box.grid_x + ad_box.column
    if ad_box.grid_y == article_bottom_grid && ad_box.grid_x <= article_x_grid && article_x_grid <= ad_box_x_max_grid
      return true
    end
    false
  end


  def self.update_section_configs
    Section.all.each do |section|
      section.save_section_config_yml
    end
  end

  def save_section_config_yml
    system "mkdir -p #{path}" unless File.directory?(path)
    section_config_yml_path = path + "/config.yml"
    yaml = section_config_hash.to_yaml
    File.open(section_config_yml_path, 'w'){|f| f.write yaml}
  end

  def article_type(box)
    if box.length == 5
      h = box[4]
      return '기고'       if h[4] == '기고'
      return 'opinion'   if h[4] == 'opinion'
      return '사설'       if h[4] == '사설'
      return 'editorial' if h[4] == 'editorial'
      return 'ad'        if h[4] =~ /^광고/
      return 'ad'        if h[4] =~ /^ad/
    end
    'article'
  end

  def self.update_page_headings
    Section.all.each do |sec|
      sec.copy_page_heading
    end
  end

  def copy_page_heading
    page_heading_template_path = "#{Rails.root}/public/#{publication_id}/page_heading/#{page_number}"
    page_heading_path = path + "/heading"
    system "cp -R #{page_heading_template_path}/ #{page_heading_path}"
  end

  def sample_ad_path
    "#{Rails.root}/public/#{publication_id}/ad/sample/#{ad_type}"
  end

  def ad_folder
    path + "/ad"
  end

  def delete_pdf_ad
    pdf_ad_path = ad_folder + "/output.pdf"
    jpg_ad_path = ad_folder + "/output.jpg"
    system "rm #{pdf_ad_path}"
    system "rm #{jpg_ad_path}"
  end

  def copy_ad
    return unless ad_type
    ad_template_path = "#{Rails.root}/public/#{publication_id}/ad/#{column}/#{ad_type}"
    ad_folder = path + "/ad"
    system "cp -R #{ad_template_path}/ #{ad_folder}"
    #code
  end

  def copy_sample_ad
    # copy random asmple ad
    ad = Dir.glob("#{sample_ad_path}/*{.jpg,.pdf}").sample
    puts "sample_ad_path:#{sample_ad_path}"
    puts "ad:#{ad}"
    puts "cp #{ad} #{ad_folder}/images/1.jpg"
    if ad
      system "cp #{ad} #{ad_folder}/images/1.jpg"
    end
  end

  def update_section_layout
    update_profile
    self.grid_width = publication.grid_width(column)
    self.save
    save_section_config_yml
    copy_page_heading
    create_articles
    generate_article_pdf
    generate_ad_box_template_pdf
    generate_pdf
  end

  def update_section_layout_if
    return if File.exist?(pdf_path)
    update_profile
    save_section_config_yml
    copy_page_heading
    create_articles
    generate_article_pdf
    generate_ad_box_template_pdf
    generate_pdf
  end

  def regerate_section_preview
    copy_page_heading
    generate_article_pdf
    generate_ad_box_template_pdf
    generate_pdf
  end

  def generate_article_pdf
    articles.each do |article|
      article.generate_pdf
    end
  end

  def generate_ad_box_template_pdf
    ad_box_templates.each do |ad|
      ad.generate_pdf
    end
  end

  def clear_section_pdf
    system("rm ##{pdf_path}")
  end

  def regenerate_pdf
    articles.each do |article|
      article.generate_pdf
    end
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman section ."
    # generate_pdf
  end

  def self.generate_pdf
    Section.all.each do |sec|
      sec.generate_pdf
    end
  end

  def generate_heading_pdf
    PageHeading.generate_pdf(self)
  end

  def generate_pdf
    # PageWorker.perform_async(path, nil)
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman section ."
  end

  def svg_unit_width
    150/column
  end

  def svg_unit_height
    15
  end

  def top_position?

  end

  def has_heading?
    section_name == '1면'
  end

  def number_of_chars(box_y, box_width, box_height, has_image)
    lines_in_box    = box_width*box_height*7  #total_lines
    lines_in_box    -= box_width*4            #lines_in_heading
    lines_in_box    -= 3                      #lines_in_subtitle
    lines_in_box    -= 2*2*7 if has_image     #lines_in_image
    lines_in_box    -= box_width*2            #lines_at_bottom
    if has_heading? && box_y == 1
      lines_in_box    -= box_width*4            #lines_at_front_page heading
    elsif box_y == 0
      lines_in_box    -= box_width*3            #lines_at_front_page heading
    end

    case column
    when 5
      char_count_per_line = 18
    when 6
      char_count_per_line = 17
    when 7
      char_count_per_line = 16
    end
    char_count = lines_in_box*char_count_per_line
    #round off to 100 units
    char_count -= char_count % 100
  end

  def svg_box
    # TODO put story number on top
    # make width for 6 column same as 7 column
    string = ""
    layout.each do |box|
      next if box.class == Hash
      if box.length == 5
        if box[4] == 'heading' || box[4] == '제목'
          # heading box
          string += "<rect fill='white' stroke='#000000' x='#{box[0]*svg_unit_width}' y='#{box[1]*svg_unit_height}' width='#{box[2]*svg_unit_width}' height='#{box[3]*svg_unit_height}'/>\n"
        elsif box[4] == 'image'
          puts "place image here ..."
        elsif box[4] && box[4] =~/광고/
          # ad box
          string += "<rect fill='lightGray' stroke='#000000' x='#{box[0]*svg_unit_width}' y='#{box[1]*svg_unit_height}' width='#{box[2]*svg_unit_width}' height='#{box[3]*svg_unit_height}'/>\n"
        else
          char_count = number_of_chars(box[1],box[2], box[3], false)
          string += "<rect fill='white' stroke='#000000' stroke-width='4' x='#{box[0]*svg_unit_width}' y='#{box[1]*svg_unit_height}' width='#{box[2]*svg_unit_width}' height='#{box[3]*svg_unit_height}'/>\n"
          string += "<text x='#{box[0]*svg_unit_width + 10} 'y='#{box[1]*svg_unit_height + 20}' stroke-width='0' class='small'>#{char_count}</text>"
          if box[2] >3 && box[3]>3
            char_count = number_of_chars(box[1], box[2], box[3], true)
            string += "<text x='#{box[0]*svg_unit_width + 10}'y='#{box[1]*svg_unit_height + 40}' stroke-width='0' class='small'>#{char_count}(사진)</text>"
          end
        end
      else
        char_count = number_of_chars(box[1],box[2], box[3], false)
        string += "<rect fill='white' stroke='#000000' stroke-width='4' x='#{box[0]*svg_unit_width}' y='#{box[1]*svg_unit_height}' width='#{box[2]*svg_unit_width}' height='#{box[3]*svg_unit_height}'/>\n"
        string += "<text x='#{box[0]*svg_unit_width + 3}'y='#{box[1]*svg_unit_height + 12}' stroke-width='0' class='small' fill='CornflowerBlue'>#{char_count}</text>"
        if box[2] >3 && box[3]>3
          char_count = number_of_chars(box[1], box[2], box[3], true)
          string += "<text x='#{box[0]*svg_unit_width + 3}'y='#{box[1]*svg_unit_height + 22}' stroke-width='0' class='small' fill='Coral'>#{char_count}(사진)</text>"
        end

       end
    end
    string
  end

  def to_svg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0' y='0' stroke='black' stroke-width='4' width='#{column*svg_unit_width}' height='#{row*svg_unit_height}'>
      #{svg_box}
    </svg>
    EOF
  end

  def page_svg_with_jpg
    "<image xlink:href='#{jpg_image_path}' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />\n"
  end

  def box_svg_with_jpg
    box_element_svg = page_svg_with_jpg
    box_element_svg += "<g transform='translate(#{doc_left_margin},#{doc_top_margin})' >\n"
    # box_element_svg += page_svg
    # box_element_svg += page_heading.box_svg if page_number == 1
    articles.each do |article|
      # next if article.inactive
      box_element_svg += article.box_svg
    end
    ad_box_templates.each do |ad|
      box_element_svg += ad.box_svg
    end
    box_element_svg += '</g>'
    box_element_svg
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

  def to_svg_with_jpg
    svg=<<~EOF
    <svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 #{doc_width} #{doc_height}' >
      <rect fill='white' x='0' y='0' width='#{doc_width}' height='#{doc_height}' />
      #{box_svg_with_jpg}
    </svg>
    EOF
  end


  def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        # get rid of id, created_at, updated_at
        # header = %w[page_number section_name profile column row order ad_type is_front_page story_count color_page draw_divider publication_id layout]
        header = %w[page_number column ad_type section_name layout]
        csv << header
        all.each do |item|
          csv << item.attributes.values_at(*header)
        end
      end
  end

  def self.to_hash_list(options = {})
      section_list = []
      filtered = column_names.dup
      filtered.shift  # remove id
      filtered.pop    # remove created_at
      filtered.pop    # remove updated_at
      all.each do |item|
        section_list << Hash[filtered.zip item.attributes.values_at(*filtered)]
      end
      section_list
  end

  def self.save_sections_for_seed
    # section_list = Section.to_hash_list
    # # save yml
    # yml_path = "#{Rails.root}/public/1/section/sections.yml"
    # File.open(yml_path, 'w'){|f| f.write section_list.to_yaml}
    # # save rb
    # rb_path = "#{Rails.root}/public/1/section/sections.rb"
    # File.open(rb_path, 'w'){|f| f.write section_list.to_s}
    # save csv
    csv_path = "#{Rails.root}/public/1/section/sections.csv"
    File.open(csv_path, 'w'){|f| f.write Section.to_csv.to_s}
  end

  # other SectionTemplate choices for current page
  def other_choices
    SectionTemplate.where(page_number: page_number).all
  end

  def make_profile
    # profile = "#{column}x#{row}_"
    profile = "#{column}x15_"
    profile += "H_" if is_front_page
    profile += "#{ad_type}_" if ad_type
    profile += story_count.to_s
    profile
  end

  def self.fix_un_finished_sections
    un_finished_sections = []
    Section.all.each do |section|
      section.update_section_layout if section.un_finished?
    end

  end

  def un_finished?
    articles.each do |article|
      return true unless article.has_pdf?
    end
    false
  end

  def has_overlapping_rect?
    #code
  end

  def has_pdf_error?
    return true unless File.exist?(pdf_path)
    false
  end

  def self.section_with_pdf_error
    pdf_error_sections = []
    Section.all.each do |section|
      # section.has_overlapping_rect?
      if section.has_pdf_error?
        pdf_error_sections << section.id
        pdf_error_sections << section.path
      end
    end
    pdf_error_sections
  end

  # prefered page for specific page_number
  def create_articles
    puts "id:#{id}"
    article_count = 0
    box_array = layout

    # delete unused articles

    if box_array.length < articles.count
      unused_count = articles.count - box_array.length
      sorted = articles.sort_by{|a| a.order}
      unused_count.times do
        article_from_last = sorted.pop
        # system("rm -rf #{article_from_last.path}")
        article_from_last.destroy
      end
    end
    box_array.each_with_index do |box, i|
      article_atts = {}
      article_atts[:section_id]  = self.id
      article_atts[:profile]  = self.profile
      article_atts[:grid_x]   = box[0]
      article_atts[:grid_y]   = box[1]
      article_atts[:column]   = box[2]
      article_atts[:row]      = box[3]
      article_atts[:order]    = article_count + 1
      article_atts[:kind]     = '기사'
      article_atts[:is_front_page]  = false
      article_atts[:is_front_page]  = true if is_front_page
      article_atts[:top_story]      = false
      article_atts[:top_story]      = true if article_atts[:order] == 1
      article_atts[:top_position]   = false
      article_atts[:top_position]   = true if box[1] == 0
      article_atts[:top_position]   = true if is_front_page && box[1] == 1
      article_atts[:on_left_edge]   = false
      article_atts[:on_left_edge]   = true if box[0] == 0
      article_atts[:on_right_edge]  = false
      article_atts[:on_right_edge]  = true if box[0] + box[2] == column
      article_atts[:page_heading_margin_in_lines]  = page_heading_margin_in_lines

      if box.last =~/^extend/
        article_atts[:extended_line_count] = box.last.split("_")[1].to_i
      elsif box.last =~/^push/
        article_atts[:pushed_line_count] = box.last.split("_")[1].to_i
      else
        article_atts[:extended_line_count] = 0
        article_atts[:pushed_line_count] = 0
      end
      article_atts[:section_id]   = self.id
      article_atts[:section]   = self
      current_rect = [box[0], box[1], box[2], box[3]]
      if box.length >= 5
        if box[4] =~/^광고/ || box[4] =~/^ad/
          ad_box_atts = {}
          ad_box_atts[:section_id]   = self.id
          ad_box_atts[:grid_x]   = box[0]
          ad_box_atts[:grid_y]   = box[1]
          ad_box_atts[:column]   = box[2]
          ad_box_atts[:row]      = box[3]
          ad_string_array = box[4].split("_")
          if ad_string_array.length == 3
            ad_string_array.shift
            ad_type = ad_string_array.join("_")
          else ad_string_array.length == 2
            ad_type = ad_string_array[1]
          end
          ad_box_atts[:ad_type]   = ad_type
          if ad_box = ad_box_templates.first
            ad_box.update(ad_box_atts)
            ad_box.generate_pdf
          else
            AdBoxTemplate.where(ad_box_atts).create!
          end
        else
          article_atts[:kind] = box[4]
          article = nil
          if article_with_order = articles.where(order: article_count + 1).first
            article_with_order.update(article_atts)
            article_with_order.generate_pdf
            current_article = article_with_order
          else
            current_article = Article.where(article_atts).create!
            # Article.where(article_atts).create!
          end
          article_count += 1
          overlap = parse_overlap(current_article.grid_rect, i)
          embedded = parse_embedded(current_rect, i)
        end
      else
        article_atts[:kind] = '기사'
        if article_with_order = articles.where(order: article_count + 1).first
          article_with_order.update(article_atts)
          article_with_order.generate_pdf
          current_article = article_with_order
        else
          current_article = Article.where(article_atts).create!
        end
        article_count += 1
        overlap = parse_overlap(current_rect, i)
        embedded = parse_embedded(current_rect, i)
      end
      # overlap means current article is overlapping with in another box, usually with ad_box
      if current_article && overlap
        current_article.overlap = overlap
        current_article.save
      end
      # embedded is true means current article is embedded in another article area
      if current_article && embedded
        current_article.embedded = true
        current_article.save
      end
    end
  end

  def parse_story_count
    count = 0
    box_array = layout
    
    box_array.each_with_index do |box, i|
      if box.length >= 5  && (box[4] == '기고' || box[4] == 'opinion' || box[4] == '사설' || box[4] == 'editorial')
        count += 1
      elsif box.length == 5 && box[4] =~ /^광고/
        self.ad_type = box[4].split("_")[1]
      else
        count += 1
      end
    end
    count
  end

  def parse_ad_type
    box_array = layout
    ad_type = "광고없음"
    box_array.each_with_index do |box, i|
      if box.length >= 5 && box[4] =~ /^광고/
        ad_string_array = box[4].split("_")
        if ad_string_array.length == 3
          ad_string_array.shift
          ad_type = ad_string_array.join("_")
        else ad_string_array.length == 2
          ad_type = ad_string_array[1]
        end
      end
    end
    ad_type
  end

  def update_profile
    # puts "++++++++++ before profile:#{profile}"
    self.story_count = parse_story_count
    self.ad_type     = parse_ad_type
    self.profile     = make_profile
    self.save
    # puts "__________ after profile:#{profile}"
    self
  end

  def description
    "#{column}단 기사:#{story_count}개"
  end

  def re_order_layout
    layout_array = layout
    # oreder rects by y position and then x position
    layout_array = layout_array.sort_by {|rect| [rect[1], rect[0]]}
    # move ad rect to the last
    rects_with_ad = layout_array.select {|rect| rect.length == 5 && rect[4] =~ /^광고/}
    if rects_with_ad.length > 0 && !(layout_array.last[4] =~ /^광고/)
      # we have a rect with ad in the middle of the list
      ad_rect = layout_array.delete(rects_with_ad.first)
      # move it to the last position
      layout_array << ad_rect
    end
    self.layout = layout_array.to_s
  end

  # save text_sty;es tp local folder
  def self.save_text_styles
    folder = "/#{Rails.root}/public/1/text_style"
    system("mkdir -p #{folder}") unless File.directory?(folder)
    path = folder + "/text_style.yml"
    styles_hash = TextStyle.current_styles_with_english_key
    File.open(path, 'w'){|f| f.write styles_hash.to_yaml}
  end


  def page_area_in_grid
    area = column*row
    area -= column if page_number == 1
    area
  end

  def layout_total_area
    boxes = eval(layout)
    boxes.map{|b| b[2]*b[3]}.reduce(:+)
  end
  # check if the template is valid
  def invalid_template?
    #first check if the area sum is valid
    
    page_area_in_grid != layout_total_area
  end

  def self.invalid_template
    invalid_section = []
    Section.all.each do|sect|
      if  sect.invalid_template?
        invalid_section << sect.id
      end
    end
    invalid_path = "#{Rails.root}/public/1/section/invalid.yml"
    File.open(invalid_path, 'w'){|f| f.write invalid_section.to_yaml}
  end

  # def self.invalid_layout?(page_number, column, row, layout)
  #   #first check if the area sum is valid
  #   page_area_in_grid = column*row
  #   page_area_in_grid -= column if page_number == 1
  #   page_area  =  page_area_in_grid
  #   boxes = eval(layout)
  #   layout_total_area = boxes.map{|b| b[2]*b[3]}.reduce(:+)
  #   page_area != layout_total_area
  # end

  private
  def parse_profile
    re_order_layout

    if page_number == 1 || is_front_page == true
      self.is_front_page                    = true
      self.page_heading_margin_in_lines     = publication.front_page_heading_margin
    elsif [22,23].include?(page_number) #[22,23]
      self.page_heading_margin_in_lines     = 4
    else
      self.is_front_page  = false
      self.page_heading_margin_in_lines     = publication.inner_page_heading_height
    end
    self.row                    = 15
    self.story_count            = parse_story_count
    self.ad_type                = parse_ad_type
    self.profile                = make_profile
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
    true
  end
end
