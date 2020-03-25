# == Schema Information
#
# Table name: text_styles
#
#  id                    :integer          not null, primary key
#  korean_name           :string
#  english               :string
#  category              :string
#  font_family           :string
#  font                  :string
#  font_size             :float
#  text_color            :string
#  alignment             :string
#  tracking              :float
#  space_width           :float
#  scale                 :float
#  text_line_spacing     :float
#  space_before_in_lines :integer
#  space_after_in_lines  :integer
#  text_height_in_lines  :integer
#  box_attributes        :text
#  markup                :string
#  graphic_attributes    :text
#  publication_id        :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  first_line_indent     :float
#
# Indexes
#
#  index_text_styles_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#



class TextStyle < ApplicationRecord
  belongs_to :publication

  validates :korean_name, presence: true
  validates :english, presence: true

  after_create :setup
  attr_reader :style_object, :font_wrapper

  # given string, create tokens
  def create_tokens(string)
    @doc          ||= HexaPDF::Document.new
    font_file     = "/Library/Fonts/newspaper/#{font}.ttf"
    @font_wrapper ||= doc.fonts.add(font_file)
    h = {}
    h[:font]                = @font_wrapper
    h[:font_size]           = font_size
    h[:character_spacing]   = tracking  if tracking && scale != 0
    h[:horizontal_scale]    = scale     if scale && scale != 100
    h
    @style_object ||= HexaPDF::Layout::Style.new(h)
    s_array = string.split(" ")
    s_array.map do |s|
      g_list  = @font_wrapper.decode_utf8(s)
      width   = g_list.map{|g| @style_object.scaled_item_width(g)}.reduce(:+)
      [s, width, id]
    end
  end

  def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        # get rif of id, created_at, updated_at
        filtered = column_names.dup
        filtered.shift
        filtered.pop
        filtered.pop
        csv << filtered
        all.each do |item|
          csv << item.attributes.values_at(*filtered)
        end
      end
  end

  def self.current_style_list
    styles_list = []
    h = {}
    filtered = column_names.dup
    filtered.shift  # delete id
    # filtered.shift  # delete name
    filtered.pop    # delete created_at
    filtered.pop    # delete updated_at
    all.each do |item|
      styles_list << Hash[filtered.zip item.attributes.values_at(*filtered)]
    end
    styles_list
  end

  def self.current_styles_with_name_key(options = {})
    # get rif of id, created_at, updated_at
    styles_hash = {}
    h = {}
    filtered = column_names.dup
    filtered.shift  # delete id
    filtered.shift  # delete korean_name
    filtered.pop    # delete created_at
    filtered.pop    # delete updated_at
    all.each do |item|
      styles_hash[item.attributes['korean_name']] = Hash[filtered.zip item.attributes.values_at(*filtered)]
    end
    styles_hash
  end

  def self.current_styles_with_english_key(options = {})
    # get rif of id, created_at, updated_at
    styles_hash = {}
    h = {}
    filtered = column_names.dup
    filtered.shift  # delete id
    filtered.delete('english')  # delete name
    filtered.pop    # delete created_at
    filtered.pop    # delete updated_at
    all.each do |item|
      styles_hash[item.attributes['english']] = Hash[filtered.zip item.attributes.values_at(*filtered)]
    end
    styles_hash
  end

  # save text_sty;es tp local folder
  def self.save_text_styles
    folder = "/#{Rails.root}/public/1/text_style"
    system("mkdir -p #{folder}") unless File.directory?(folder)
    path = folder + "/text_style.yml"
    styles_hash = TextStyle.current_styles_with_english_key
    File.open(path, 'w'){|f| f.write styles_hash.to_yaml}
  end

  def self.save_current_styles_with_name_key
    path = "#{Rails.root}/public/1" + "/text_style/current_qtext_styles_with_name_key.rb"
    styles_hash = self.current_styles_with_name_key
    File.open(path, 'w'){|f| f.write styles_hash.to_s}
  end

  def save_current_styles_with_english_key
    # folder = "/Users/Shared/SoftwareLab/newspaper_text_style"
    # path = folder + "/#{publication.name}.yml"
    folder = "/Users/Shared/SoftwareLab/newsman/#{publication.name}"
    system("mkdir -p #{folder}") unless File.directory?(folder)
    path = folder + "/text_style.yml"
    styles_hash = TextStyle.current_styles_with_english_key
    File.open(path, 'w'){|f| f.write styles_hash.to_yaml}
    path = folder + "/#{publication.name}.rb"
    File.open(path, 'w'){|f| f.write styles_hash.to_s}
  end

  def self.sample_articles
    sample_collection = []
    sample_collection << Article.where(column: 1, row: 4, top_story: false).first
    sample_collection << Article.where(column: 2, row: 4, top_story: false).first

    sample_collection << Article.where(column: 3, row: 4, top_story: true).first
    sample_collection << Article.where(column: 3, row: 4, top_position: true).first
    sample_collection << Article.where(column: 3, row: 4, top_story: false).first

    sample_collection << Article.where(column: 4, row: 4, top_story: true).first
    sample_collection << Article.where(column: 4, row: 4, top_position: true).first
    sample_collection << Article.where(column: 4, row: 4, top_story: false).first

    sample_collection << Article.where(column: 5, row: 4, top_story: true).first
    sample_collection << Article.where(column: 5, row: 4, top_position: true).first
    sample_collection << Article.where(column: 5, row: 4, top_story: false).first

    puts sample_collection[0].class
    puts sample_collection.length
    sample_collection
  end

  def self.update_sample_articles
    # TextStyle.generate_sample_pdf
    current_styles  = self.current_styles_with_name_key
    self.sample_articles.each do |sample_article|
      sample_article.generate_custom_style_pdf(current_styles)
    end
  end

  def path
    "#{Rails.root}/public/#{publication.id}/text_style/#{english}"
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
    path + "/output.pdf"
  end

  def jpg_path
    path + "/output.jpg"
  end

  def pdf_image_path
    "/#{publication.id}/text_style/#{english}/output.pdf"
  end

  def jpg_image_path
    "/#{publication.id}/text_style/#{english}/output.jpg"
  end

  def setup
    system("mkdir -p #{path}") unless File.directory?(path)
  end

  def save_layout
    sample_text = "우리는 민족중흥의 역사적 사명에 대해서는 전혀 들은바 없이 그냥 이땅에 태어 났다. 그래서 우리는 가끔 당황스러워 한다."
    attrs                     = {}
    attrs[:font]              = font
    attrs[:font_size]         = font_size
    attrs[:text_color]        = text_color        if text_color && text_color != ""
    attrs[:alignment]         = alignment
    attrs[:tracking]          = tracking          if tracking
    attrs[:space_width]       = space_width       if space_width
    attrs[:scale]             = scale             if scale
    attrs[:text_line_spacing] = text_line_spacing if text_line_spacing
    if box_attributes
      box_attributes_hash       = eval(box_attributes)
      if box_attributes_hash.class == Hash && box_attributes_hash.keys.length > 0
        attrs[:box_attributes]    = box_attributes
      end
    end
    attrs[:width]     = 300
    attrs[:height]    = 200
    attrs[:margin]    = 20
    attrs_string = attrs.to_s.gsub("{", "").gsub("}", "")
    layout_content=<<~EOF
    RLayout::Container.new(width: 400, height: 200) do
      text('#{sample_text}', #{attrs_string})
    end
    EOF
    system("mkdir -p #{path}") unless File.exist?(path)
    File.open(layout_path, 'w'){|f| f.write layout_content}
  end

  def generate_pdf
    save_layout
    system "cd #{path} && /Applications/newsman.app/Contents/MacOS/newsman article ."
  end
end
