# frozen_string_literal: true

# == Schema Information
#
# Table name: graphics
#
#  id                    :bigint           not null, primary key
#  caption               :string
#  column                :integer
#  description           :text
#  detail_mode           :boolean
#  draw_frame            :boolean          default(FALSE)
#  extra_height_in_lines :integer
#  fit_type              :string
#  graphic               :string
#  grid_x                :integer
#  grid_y                :integer
#  height_in_lines       :integer
#  move_level            :integer
#  order                 :integer
#  page_number           :integer
#  position              :string
#  reporter_graphic_path :string
#  row                   :integer
#  source                :string
#  story_number          :integer
#  sub_grid_size         :string
#  title                 :string
#  x_grid                :integer
#  y_in_lines            :integer
#  zoom_direction        :integer
#  zoom_level            :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  issue_id              :integer
#  working_article_id    :bigint
#
# Indexes
#
#  index_graphics_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

class Graphic < ApplicationRecord
  belongs_to :issue, optional: true
  belongs_to :working_article, optional: true
  # mount_uploader :graphic, GraphicUploader
  before_create  :set_default
  before_save    :save_default_value
  # after_save     :pdf_to_jpg
  has_one_attached :storage_graphic

  def save_as_page_layout
    h = {}
    h[:position]              = position
    h[:column]                = column
    h[:row]                   = row
    h[:x_grid]                = x_grid if x_grid
    h  
  end

  def info
    h = {}
    h[:position] = position
    if extra_height_in_lines && extra_height_in_lines != 0
      h[:extra_height_in_lines] = extra_height_in_lines
    end
    h[:column]                = column
    h[:row]                   = row
    h[:x_grid]                = x_grid if x_grid
    h
  end

  def image_path
    if storage_graphic.attached?
      ActiveStorage::Blob.service.send(:path_for, storage_graphic.key)
    end
    # if graphic.url
    #   "#{Rails.root}/public" + graphic.url
    # elsif reporter_graphic_path
    #   "#{Rails.root}/public" + reporter_graphic_path
    # else
    #   "#{Rails.root}/public" + '/place_holder_image.jpg'
    # end
  end

  def image_ext
    File.extname(storage_graphic.blob[:filename])
  end

  def pdf_to_jpg
    image_name = File.basename(graphic.path).split('.').first
    dir_path = File.dirname(image_path)
    # image_basename  = File.basename(graphic.url).split(".").first
    system("convert -density 300 -resize 1200 #{image_path}/ #{dir_path}/#{image_name}.jpg")
  end

  def size_string
    width_in_mm   = ((working_article.grid_width * column - working_article.gutter) * 0.352778).round(2)
    # 4 is value adjustef to align image with body text
    # extra_height_in_lines = 0 unless extra_height_in_lines
    height_in_mm  = ((working_article.grid_height * row + working_article.body_line_height * extra_height_in_lines - 4) * 0.352778).round(3)
    "#{width_in_mm}mm x #{height_in_mm}mm"
  end

  def publication
    issue.publication
  end

  def page_number
    working_article.page_number
  end

  # def order
  #   working_article.order
  # end

  def article_order
    working_article.order
  end

  # currnt image count
  # this becomes part of next images's file name
  # page_number_article_number_graphic_count.extension
  def graphic_count
    working_article.graphics.length
  end

  # '최적' '가로', '세로', '욱여넣기'
  # MAGE_FIT_TYPE_ORIGINAL        = 0
  # IMAGE_FIT_TYPE_VERTICAL       = 1
  # IMAGE_FIT_TYPE_HORIZONTAL     = 2
  # IMAGE_FIT_TYPE_KEEP_RATIO     = 3
  # IMAGE_FIT_TYPE_IGNORE_RATIO   = 4
  # IMAGE_FIT_TYPE_REPEAT_MUTIPLE = 5
  # IMAGE_CHANGE_BOX_SIZE         = 6 #change box size to fit image source as is at origin
  def graphic_layout_hash
    h = {}
    h[:image_path]        = image_path
    h[:column]            = column
    h[:row]               = row
    h[:position]          = position.to_i
    h[:extra_height_in_lines] = extra_height_in_lines
    h[:is_float]          = true
    h[:image_kind]        = 'graphic'
    h[:fit_type] = case fit_type
                   when '최적'
                     3
                   when '세로'
                     1
                   when '가로'
                     2
                   when '욱여넣기'
                     4
                   else
                     3
                   end
    # h[:fit_type]          = fit_type if fit_type
    h[:x_grid]            = x_grid - 1 if x_grid # user_input - 1
    h[:draw_frame]        = draw_frame || false
    h
  end

  # set current_article_id, if page_number and story_number is given
  def update_change
    return unless page_number
    return unless story_number

    current_article_id = working_article_id
    page = Page.where(issue_id: issue_id, page_number: page_number).first
    unless page
      puts "we don't have page!!!"
      return
    end
    new_article = WorkingArticle.where(page_id: page.id, order: story_number).first
    unless new_article
      puts "we don't the article with story number!!!"
      return
    end
    puts "new_article.id:#{new_article.id}"
    if new_article && new_article.id != current_article_id
      puts 'change to different article'
      self.working_article_id = new_article.id
      self.used_in_layout = false
      save
      place_image
      # clear image from current_article, if it exits
    end
    # if working_article
    #   working_article.generate_pdf
    #   working_article.update_page_pdf
    # end
  end

  def self.current_images
    Image.where(issue_id: Issue.last.id).all
  end

  def self.place_all_images
    Image.current_images.each do |current_image|
      current_image.place_image unless current_image.used_in_layout
    end
  end

  def place_image
    if page_number && story_number
      page = Page.where(issue_id: issue_id, page_number: page_number).first
      return unless page

      working_article = WorkingArticle.where(page_id: page.id, order: story_number).first
      return unless working_article

      self.working_article_id = working_article.id
      working_article.generate_pdf_with_time_stamp
      working_article.update_page_pdf
      self.used_in_layout = true
      save
    end
  end

  def self.clear_all_images
    Image.current_images.each(&:clear_image)
  end

  def clear_image
    if working_article && used_in_layout
      working_article.generate_pdf_with_time_stamp
      working_article.update_page_pdf
      self.used_in_layout = false
      save
    end
  end

  # return array of image_basename.split("_")
  # we want to see if page_number and story_number are specified in the file name.
  def parse_file_name
    return [] unless graphic

    image_basename = File.basename(graphic.url)
    if image_basename =~ /^\d/
      image_basename.split('_')
    else
      []
    end
  end

  def current_image_size
    "#{column}x#{row}"
  end

  def change_size(size)
    return false if size == current_image_size

    if size == 'auto'
      new_column, new_row, new_lines = working_article.calculate_fitting_image_size(column, row, extra_height_in_lines)
      if column == new_column && row == new_row && lines == new_lines
        return false
      end

      self.column = new_column
      self.row    = new_row
      self.lines  = new_lines
      save
      true
    elsif size.include?('x')
      size_array  = size.split('x')
      self.column = column[0]
      self.row    = column[1]
      save
      true
    else
      puts 'wrong size format!!!'
      return false
    end
  end

  def save_default_value
    self.extra_height_in_lines  = 0 unless extra_height_in_lines
    self.row                    = 2 unless row
  end

  def possible_order_choices
    if working_article.graphics.length < 2
      nil
    else
      (1..working_article.graphics.length).to_a
      # working_article.graphics.map{|i| i.order}.sort
    end
  end

  # this is called  after graphic order is changed
  def update_sybling_orders(previous_position)
    if order > previous_position # moving down
      working_article.graphics.sort_by(&:updated_at).reverse.sort_by(&:order).each_with_index do |syb, i|
        next if syb == self
        syb.order = i + 1
        syb.save
      end
    else # moving up
      working_article.graphics.sort_by(&:updated_at).sort_by(&:order).each_with_index do |syb, i|
        next if syb == self
        syb.order = i + 1
        syb.save
      end
    end
  end

  def static_image_path
    # working_article.static_html_path + "#{working_article.pillar_order}-#{order}"
    working_article.static_images_folder + "/#{@image_basename}"
  end

  def static_image_url
    # TODO: put correct image file extension
    # "./images/#{working_article.pillar_order}-graphic-#{order}"
    "./images/#{@image_basename}"
  end

  def copy_graphic_to_static
    @image_basename = File.basename(image_path)
    system("cp #{image_path} #{static_image_path}")
  end

  def to_html
   s ="<image src='#{static_image_url}' class='w-100 mb-5'></image>\n"
  #  s+= "<strong>#{caption_title}</string>#{caption}" if caption || caption_title
  end

  def set_storage_image_path(new_image_path)
    # url = URI.parse("https://your-url.com/abc.mp3")
    # filename = File.basename(url.path)
    # file = URI.open(url)
    # user = User.first
    # user.avatar.attach(io: file, filename: filename)
    return unless new_image_path
    filename = File.basename(new_image_path)
    self.storage_graphic.attach(io: File.open(new_image_path, 'rb'), filename: filename)
  end

  private

  def set_default
    self.column                 = 1 unless column
    self.row                    = 2 unless row
    self.extra_height_in_lines  = 0 unless extra_height_in_lines
    self.position               = 3 unless position
    self.fit_type               = 3 unless fit_type # '최적' '상하', '좌우', '욱여넣기'

    if working_article_id
      wa = WorkingArticle.find(working_article_id)
      self.issue_id         = wa.page.issue.id
      self.page_number      = wa.page.page_number
      self.story_number     = wa.order
      self.order            = working_article.graphics.length + 1

    elsif graphic
      parsed_name_array = parse_file_name
      if parsed_name_array.length >= 2
        self.page_number      = parsed_name_array[0].to_i
        self.story_number     = parsed_name_array[1].to_i
        self.column = parsed_name_array[3] if parsed_name_array.length >= 4
        self.row = parsed_name_array[4] if parsed_name_array.length >= 5
      end
    end
  end
end
