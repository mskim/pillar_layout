# frozen_string_literal: true

require 'happymapper'
require 'yaml'
require 'pry'
# require 'respec/autorun'
require 'date'
require 'fileutils'
require 'etc'

class Header
  include HappyMapper
  tag 'Header'
  element :Action, String, tag: 'Action'
  element :ServiceType, String, tag: 'ServiceType'
  element :ContentID, String, tag: 'ContentID'
  element :SendDate, String, tag: 'SendDate'
  element :SendTime, String, tag: 'SendTime'

  def to_hash
    h = {}
    h[:action] = self.Action if self.Action
    h[:service_type] = self.ServiceType if self.ServiceType
    h[:content_id] = self.ContentID if self.ContentID
    h[:date] = self.SendDate if self.SendDate
    h[:time] = self.SendTime if self.SendTime
    h
  end
end
class CodeCategory
  include HappyMapper
  tag 'Category'

  attribute :code, String, tag: 'code'
  attribute :name, String, tag: 'name'

  def to_hash
    h = {}
    h[:code]     = code if code
    h[:name]     = name if name
    h
  end
end

class ClassCode
  include HappyMapper
  tag 'ClassCode'
  attribute :code, String, tag: 'code'
  attribute :name, String, tag: 'name'
  def to_hash
    h = {}
    h[:code]     = code if code
    h[:name]     = name if name
    h
  end
end

class Class
  include HappyMapper
  tag 'Class'
  has_many :class_codes, ClassCode

  def to_hash
    h = []
    class_codes.each do |class_code|
      h << class_code.to_hash
    end
    # h[:class_code]     = self.class_code if self.class_code
    h
  end
end

class AttributeCode
  include HappyMapper
  tag 'AttributeCode'
  attribute :code, String, tag: 'code'
  attribute :name, String, tag: 'name'
  def to_hash
    h = {}
    h[:code]     = code if code
    h[:name]     = name if name
    h
  end
end

class Attribute
  include HappyMapper
  tag 'Attribute'
  has_many :attribute_codes, AttributeCode

  def to_hash
    h = []
    attribute_codes.each do |_attribute_code|
      h << cattribute.to_hash
    end
    # h[:attribute_code]     = self.attribute_code if self.attribute_code
    h
  end
end

class Metadata
  include HappyMapper
  tag 'Metadata'
  has_one :Urgency, String
  has_one :Category, CodeCategory
  has_one :page_ref, String
  has_one :Class, String, tag: 'Class'
  has_one :Attribute, String, tag: 'Attribute'
  has_one :Credit, String
  has_one :Source, String

  def to_hash
    h = {}
    h[:urgency] = self.Urgency if self.Urgency
    h[:category] = self.Category.to_hash if self.Category
    h[:page_ref] = self.page_ref if self.Urgency
    # h[:class] = self.Class.to_s if self.Class
    h[:credit] = self.Credit if self.Credit
    h[:source] = self.Source if self.Source
    h
  end
end

class NewsContent
  include HappyMapper
  tag 'NewsContent'
  has_one :Title, String
  # has_one :SubTitle, String
  has_one :Body, String
  has_one :MultiMedia, String
  has_one :AppendData, String

  def to_hash
    h = {}
    h[:title]     = self.Title if self.Title
    # h[:subtitle]  = self.SubTitle if self.SubTitle
    h[:body]      = self.Body if self.Body
    h[:picture]   = self.MultiMedia if self.MultiMedia
    h[:appenddata] = self.AppendData if self.AppendData
    h
  end
end

class YNewsML
  include HappyMapper
  tag 'YNewsML'
  has_one :Header, Header
  has_one :Metadata, Metadata
  has_one :NewsContent, NewsContent
  # has_one :link, String, xpath: 'Header'

  def to_hash
    h = self.Header.to_hash
    h.merge! self.Metadata.to_hash
    h.merge! self.NewsContent.to_hash
    h
  end

  # def self.chmod(source_dir)
  #   total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
  #   Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
  #     filename_date = source_file.split("/").last.scan(/\d{8}/).first
  #     destination_dir = "/Volumes/wire_source/wire_source/#{filename_date}"
  #     FileUtils.mkdir_p "#{destination_dir}" unless File.exists?(destination_dir)
  #     # sudo_passwd = ""
  #     # system("echo #{sudo_passwd} | sudo -S chown apple #{source_file}")
  #     puts "source_file:#{source_file}"
  #   end
  # end

  # def self.mvfile(source_dir)
  #   total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
  #   Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
  #     filename_date = source_file.split("/").last.scan(/\d{8}/).first
  #     destination_dir = "/Volumes/wire_source/wire_source/#{filename_date}"
  #     FileUtils.mkdir_p "#{destination_dir}" unless File.exists?(destination_dir)
  #     FileUtils.mv(source_file, destination_dir)
  #     left_file = Dir[File.join(source_dir, '*')].count { |f| File.file?(f) }
  #     puts "#{source_dir}...뉴스파일 이동중... #{total_file - left_file}/#{total_file}개 처리"
  #     # system("sudo mv #{source_file} #{destination_dir}")
  #   end
  # end

  def self.ytn_101
    @source = '101_KOR'
    # source_location = "/Volumes/wire_source/wire_source/#{@source}"
    source_location = "#{Rails.root}/wire_source/#{@source}"
    parse_wire(source_location)
  end

  def self.ytn_201
    @source = '201_PHOTO_YNA'
    source_location = "#{Rails.root}/wire_source/#{@source}"
    parse_wire(source_location)
  end

  def self.ytn_202
    @source = '202_PHOTO_TR'
    source_location = "#{Rails.root}/wire_source/#{@source}"
    parse_wire(source_location)
  end

  def self.ytn_203
    @source = '203_GRAPHIC'
    source_location = "#{Rails.root}/wire_source/#{@source}"
    parse_wire(source_location)
  end

  def self.ytn_205
    @source = '205_PHOTO_FR_YNA'
    source_location = "#{Rails.root}/wire_source/#{@source}"
    parse_wire(source_location)
  end

  def self.ytn_401
    @source = '401_PR'
    source_location = "#{Rails.root}/wire_source/#{@source}"
    parse_wire(source_location)
  end

  # def self.new_ytn
  #   require 'date'
  #   today = Date.today
  #   today_string = today.strftime("%Y%m%d")
  #   # source_location = '/Volumes/211.115.91.190'
  #   # source_location = "/yhnews/wire_source"
  #   source_location = "/Volumes/wire_source/wire_source"
  #   ytn_today_story_folder = source_location + "/101_KOR/#{today_string}"
  #   ytn_today_image_folder = source_location + "/201_PHOTO_YNA/#{today_string}"
  #   ytn_today_graphic_folder = source_location + "/203_GRAPHIC/#{today_string}"

  #   ytn_101_KOR_folder = source_location + "/101_KOR"
  #   ytn_201_PHOTO_YNA_folder = source_location + "/201_PHOTO_YNA"
  #   ytn_202_PHOTO_TR_folder = source_location + "/202_PHOTO_TR"
  #   ytn_203_GRAPHIC_folder = source_location + "/203_GRAPHIC"
  #   ytn_205_PHOTO_FR_YNA_folder = source_location + "/205_PHOTO_FR_YNA"
  #   ytn_401_PR_folder = source_location + "/401_PR"

  #   # self.chmod_wire(ytn_101_KOR_folder)
  #   # self.chmod_wire(ytn_201_PHOTO_YNA_folder)
  #   # self.chmod_wire(ytn_202_PHOTO_TR_folder)
  #   # self.chmod_wire(ytn_203_GRAPHIC_folder)
  #   # self.chmod_wire(ytn_205_PHOTO_FR_YNA_folder)
  #   # self.chmod_wire(ytn_401_PR_folder)

  #   # self.parse_new_wire_story_xml(ytn_today_story_folder)
  #   # self.parse_new_wire_picture_xml(ytn_today_image_folder)
  #   # self.parse_new_wire_graphic_xml(ytn_today_graphic_folder)
  #   self.parse_new_wire_story_xml(ytn_101_KOR_folder)
  #   self.parse_new_wire_picture_xml(ytn_201_PHOTO_YNA_folder)
  #   self.parse_new_wire_photo_tr(ytn_202_PHOTO_TR_folder)
  #   self.parse_new_wire_graphic_xml(ytn_203_GRAPHIC_folder)
  #   self.parse_new_wire_photo_fr_yna(ytn_205_PHOTO_FR_YNA_folder)
  #   self.parse_new_wire_pr(ytn_401_PR_folder)

  #   # delete files that are week old
  #   YhArticle.delete_week_old(today)
  #   YhPicture.delete_week_old(today)
  #   YhGraphic.delete_week_old(today)
  # end

  def self.parse_wire(source_dir)
    today = Date.today

    if @source == '101_KOR'
      @class = YhArticle
    elsif @source == '202_PHOTO_TR'
      @class = YhPhotoTr
    elsif @source == '201_PHOTO_YNA'
      @class = YhPicture
    elsif @source == '203_GRAPHIC'
      @class = YhGraphic
    elsif @source == '205_PHOTO_FR_YNA'
      @class = YhPhotoFrYna
    elsif @source == '401_PR'
      @class = YhPr
    end

    @class.delete_week_old(today)
    total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
    Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
      if File.extname(source_file) == '.ai' || File.extname(source_file) == '.jpg' || File.extname(source_file) == '.png'
        Dir.glob("#{source_dir}/*").select { |img_file| File.extname(img_file) == '.ai' || File.extname(img_file) == '.jpg' || File.extname(source_file) == '.png' }.each do |img_file|
          filename_date = img_file.split('/').last.scan(/\d{8}/).first
          destination_dir = "#{source_dir}/#{filename_date}"
          unless File.directory?(destination_dir)
            FileUtils.mkdir_p destination_dir.to_s
          end
          FileUtils.mv(img_file, destination_dir)
        end
      else
        Dir.glob("#{source_dir}/*").select { |xml_file| File.extname(xml_file) == '.xml' }.each do |xml_file|
          filename_date = xml_file.split('/').last.scan(/\d{8}/).first
          destination_dir = "#{source_dir}/#{filename_date}"
          unless File.directory?(destination_dir)
            FileUtils.mkdir_p destination_dir.to_s
          end
          content_id = File.basename(xml_file, '.xml').split('_').first
          received = @class.find_by(content_id: content_id)
          if File.basename(xml_file, '.xml').split('_').last == 'C'
            unless received
              xml = File.open(xml_file, 'r', &:read)
              picture_hash = YNewsML.parse(xml).to_hash
              picture_hash[:content_id] = content_id
              @class.create(picture_hash)
              FileUtils.mv(xml_file, destination_dir)
            end
          else
            xml = File.open(xml_file, 'r', &:read)
            picture_hash = YNewsML.parse(xml).to_hash
            picture_hash[:content_id] = content_id
            @class.update(picture_hash)
            FileUtils.mv(xml_file, destination_dir)
          end
          left_file = Dir.glob("#{source_dir}/*").count { |xml_file| File.extname(xml_file) == '.xml' }
          puts "#{xml_file}...뉴스파일 이동중... #{total_file - left_file}/#{total_file}개 처리"
        end
      end
    end
  end

  # def self.parse_new_wire_story_xml(source_dir)
  #   total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
  #   Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
  #     # puts "source_file: #{source_file}"
  #     filename_date = source_file.split("/").last.scan(/\d{8}/).first
  #     destination_dir = "#{source_dir}/#{filename_date}"
  #     FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #     # sudo_passwd = ""
  #     # system("echo #{sudo_passwd} | sudo -S chown apple #{source_file}")
  #     content_id = File.basename(source_file, ".xml").split("_").first
  #     received = YhArticle.find_by(content_id: content_id)
  #     update_id = File.basename(source_file, ".xml")
  #     if File.basename(source_file, ".xml").split("_").last == "C"
  #       unless received
  #         xml = File.open(source_file, 'r'){|f| f.read}
  #         story_hash = YNewsML.parse(xml).to_hash
  #         story_hash[:content_id] = content_id
  #         YhArticle.create(story_hash)
  #         FileUtils.mv(source_file, destination_dir)
  #       end
  #     else
  #       xml = File.open(source_file, 'r'){|f| f.read}
  #       story_hash = YNewsML.parse(xml).to_hash
  #       story_hash[:content_id] = content_id
  #       # update_id = YhArticle.find_by(content_id: content_id).id
  #       YhArticle.update(story_hash)
  #       FileUtils.mv(source_file, destination_dir)
  #     end
  #     # FileUtils.mv(source_file, destination_dir) unless File.exists?(source_file)
  #     left_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
  #     puts "#{source_file}...뉴스파일 이동중... #{total_file - left_file}/#{total_file}개 처리"
  #   end
  # end

  # def self.parse_new_wire_picture_xml(source_dir)
  #   total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
  #   Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
  #     if File.extname(source_file) == '.jpg'
  #       Dir.glob("#{source_dir}/*").select { |img_file| File.extname(img_file) == '.jpg' }.each do |img_file|
  #         # puts "img_file: #{img_file}"
  #         filename_date = img_file.split("/").last.scan(/\d{8}/).first
  #         destination_dir = "#{source_dir}/#{filename_date}"
  #         FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #         # sudo_passwd = ""
  #         # system("echo #{sudo_passwd} | sudo -S chown apple #{img_file}")
  #         FileUtils.mv(img_file, destination_dir)
  #       end
  #     else
  #       # File.extname(source_file) == '.xml'
  #       Dir.glob("#{source_dir}/*").select { |xml_file| File.extname(xml_file) == '.xml' }.each do |xml_file|
  #         # puts "xml_file: #{xml_file}"
  #         filename_date = xml_file.split("/").last.scan(/\d{8}/).first
  #         destination_dir = "#{source_dir}/#{filename_date}"
  #         FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #         # sudo_passwd = ""
  #         # system("echo #{sudo_passwd} | sudo -S chown apple #{xml_file}")
  #         content_id = File.basename(xml_file, ".xml").split("_").first
  #         received = YhPicture.find_by(content_id: content_id)
  #         if File.basename(xml_file, ".xml").split("_").last == "C"
  #           unless received
  #             xml = File.open(xml_file, 'r'){|f| f.read}
  #             picture_hash = YNewsML.parse(xml).to_hash
  #             picture_hash[:content_id] = content_id
  #             YhPicture.create(picture_hash)
  #             FileUtils.mv(xml_file, destination_dir)
  #           end
  #         else
  #           xml = File.open(xml_file, 'r'){|f| f.read}
  #           picture_hash = YNewsML.parse(xml).to_hash
  #           picture_hash[:content_id] = content_id
  #           YhPicture.update(picture_hash)
  #           FileUtils.mv(xml_file, destination_dir)
  #         end
  #         # FileUtils.mv(source_file, destination_dir) unless File.exists?(source_file)
  #         left_file = Dir.glob("#{source_dir}/*").count { |xml_file| File.extname(xml_file) == '.xml' }
  #         puts "#{xml_file}...뉴스파일 이동중... #{total_file - left_file}/#{total_file}개 처리"
  #       end
  #     end
  #   end
  # end

  # def self.parse_new_wire_photo_tr(source_dir)
  #   total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
  #   Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
  #     if File.extname(source_file) == '.jpg'
  #       Dir.glob("#{source_dir}/*").select { |img_file| File.extname(img_file) == '.jpg' }.each do |img_file|
  #       # puts "img_file: #{img_file}"
  #       filename_date = img_file.split("/").last.scan(/\d{8}/).first
  #       destination_dir = "#{source_dir}/#{filename_date}"
  #       FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #       # sudo_passwd = ""
  #       # system("echo #{sudo_passwd} | sudo -S chown apple #{img_file}")
  #       FileUtils.mv(img_file, destination_dir)
  #       end
  #     else
  #       # File.extname(source_file) == '.xml'
  #       Dir.glob("#{source_dir}/*").select { |xml_file| File.extname(xml_file) == '.xml' }.each do |xml_file|
  #         # puts "xml_file: #{xml_file}"
  #         filename_date = xml_file.split("/").last.scan(/\d{8}/).first
  #         destination_dir = "#{source_dir}/#{filename_date}"
  #         FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #         # sudo_passwd = ""
  #         # system("echo #{sudo_passwd} | sudo -S chown apple #{xml_file}")
  #         content_id = File.basename(xml_file, ".xml").split("_").first
  #         binding.pry
  #         received = YhPhotoTr.find_by(content_id: content_id) if @source == "202_PHOTO_TR"
  #         if File.basename(xml_file, ".xml").split("_").last == "C"
  #           unless received
  #             xml = File.open(xml_file, 'r'){|f| f.read}
  #             picture_hash = YNewsML.parse(xml).to_hash
  #             picture_hash[:content_id] = content_id
  #             YhPhotoTr.create(picture_hash)
  #             FileUtils.mv(xml_file, destination_dir)
  #           end
  #         else
  #           xml = File.open(xml_file, 'r'){|f| f.read}
  #           picture_hash = YNewsML.parse(xml).to_hash
  #           picture_hash[:content_id] = content_id
  #           YhPhotoTr.update(picture_hash)
  #           FileUtils.mv(xml_file, destination_dir)
  #         end
  #         left_file = Dir.glob("#{source_dir}/*").count { |xml_file| File.extname(xml_file) == '.xml' }
  #         puts "#{xml_file}...뉴스파일 이동중... #{total_file - left_file}/#{total_file}개 처리"
  #       end
  #     end
  #   end
  # end

  # def self.parse_new_wire_photo_fr_yna(source_dir)
  #   # binding.pry
  #   total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
  #   Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
  #     if File.extname(source_file) == '.jpg'
  #       Dir.glob("#{source_dir}/*").select { |img_file| File.extname(img_file) == '.jpg' }.each do |img_file|
  #         # puts "img_file: #{img_file}"
  #         filename_date = img_file.split("/").last.scan(/\d{8}/).first
  #         destination_dir = "#{source_dir}/#{filename_date}"
  #         FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #         # sudo_passwd = ""
  #         # system("echo #{sudo_passwd} | sudo -S chown apple #{img_file}")
  #         FileUtils.mv(img_file, destination_dir)
  #       end
  #     else
  #       # File.extname(source_file) == '.xml'
  #       Dir.glob("#{source_dir}/*").select { |xml_file| File.extname(xml_file) == '.xml' }.each do |xml_file|
  #         # puts "xml_file: #{xml_file}"
  #         filename_date = xml_file.split("/").last.scan(/\d{8}/).first
  #         destination_dir = "#{source_dir}/#{filename_date}"
  #         FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #         # sudo_passwd = ""
  #         # system("echo #{sudo_passwd} | sudo -S chown apple #{xml_file}")
  #         content_id = File.basename(xml_file, ".xml").split("_").first
  #         received = YhPhotoFrYna.find_by(content_id: content_id)
  #         if File.basename(xml_file, ".xml").split("_").last == "C"
  #           unless received
  #             xml = File.open(xml_file, 'r'){|f| f.read}
  #             picture_hash = YNewsML.parse(xml).to_hash
  #             picture_hash[:content_id] = content_id
  #             YhPhotoFrYna.create(picture_hash)
  #             FileUtils.mv(xml_file, destination_dir)
  #           end
  #         else
  #           xml = File.open(xml_file, 'r'){|f| f.read}
  #           picture_hash = YNewsML.parse(xml).to_hash
  #           picture_hash[:content_id] = content_id
  #           YhPhotoFrYna.update(picture_hash)
  #           FileUtils.mv(xml_file, destination_dir)
  #         end
  #         # FileUtils.mv(source_file, destination_dir) unless File.exists?(source_file)
  #         left_file = Dir.glob("#{source_dir}/*").count { |xml_file| File.extname(xml_file) == '.xml' }
  #         puts "#{xml_file}...뉴스파일 이동중... #{total_file - left_file}/#{total_file}개 처리"
  #       end
  #     end
  #   end
  # end

  # def self.parse_new_wire_pr(source_dir)
  #   total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
  #   Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
  #     if File.extname(source_file) == '.jpg'
  #       Dir.glob("#{source_dir}/*").select { |img_file| File.extname(img_file) == '.jpg' }.each do |img_file|
  #         # puts "img_file: #{img_file}"
  #         filename_date = img_file.split("/").last.scan(/\d{8}/).first
  #         destination_dir = "#{source_dir}/#{filename_date}"
  #         FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #         # sudo_passwd = ""
  #         # system("echo #{sudo_passwd} | sudo -S chown apple #{img_file}")
  #         FileUtils.mv(img_file, destination_dir)
  #       end
  #     else
  #       # File.extname(source_file) == '.xml'
  #       Dir.glob("#{source_dir}/*").select { |xml_file| File.extname(xml_file) == '.xml' }.each do |xml_file|
  #         # puts "xml_file: #{xml_file}"
  #         filename_date = xml_file.split("/").last.scan(/\d{8}/).first
  #         destination_dir = "#{source_dir}/#{filename_date}"
  #         FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #         # sudo_passwd = ""
  #         # system("echo #{sudo_passwd} | sudo -S chown apple #{xml_file}")
  #         content_id = File.basename(xml_file, ".xml").split("_").first
  #         received = YhPr.find_by(content_id: content_id)
  #         if File.basename(xml_file, ".xml").split("_").last == "C"
  #           unless received
  #             xml = File.open(xml_file, 'r'){|f| f.read}
  #             picture_hash = YNewsML.parse(xml).to_hash
  #             picture_hash[:content_id] = content_id
  #             YhPr.create(picture_hash)
  #             FileUtils.mv(xml_file, destination_dir)
  #           end
  #         else
  #           xml = File.open(xml_file, 'r'){|f| f.read}
  #           picture_hash = YNewsML.parse(xml).to_hash
  #           picture_hash[:content_id] = content_id
  #           YhPr.create(picture_hash)
  #           FileUtils.mv(xml_file, destination_dir)
  #         end
  #           # FileUtils.mv(source_file, destination_dir) unless File.exists?(source_file)
  #         left_file = Dir.glob("#{source_dir}/*").count { |xml_file| File.extname(xml_file) == '.xml' }
  #         puts "#{xml_file}...뉴스파일 이동중... #{total_file - left_file}/#{total_file}개 처리"
  #       end
  #     end
  #   end
  # end

  # def self.parse_new_wire_graphic_xml(source_dir)
  #   total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) }
  #   Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
  #     # sudo_passwd = ""
  #     # system("echo #{sudo_passwd} | sudo -S chown apple #{source_file}")
  #     if File.extname(source_file) == '.ai' || File.extname(source_file) == '.jpg' || File.extname(source_file) == '.png'
  #       Dir.glob("#{source_dir}/*").select { |img_file| File.extname(img_file) == '.ai' || File.extname(img_file) == '.jpg' || File.extname(source_file) == '.png' }.each do |img_file|
  #         # puts "img_file: #{img_file}"
  #         filename_date = img_file.split("/").last.scan(/\d{8}/).first
  #         destination_dir = "#{source_dir}/#{filename_date}"
  #         FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #         # sudo_passwd = ""
  #         # system("echo #{sudo_passwd} | sudo -S chown apple #{img_file}")
  #         FileUtils.mv(img_file, destination_dir)
  #           # puts total_file = Dir[File.join(source_dir, '*')].count { |f| File.file?(f) }
  #       end
  #     else
  #       # File.extname(source_file) == '.xml'
  #       Dir.glob("#{source_dir}/*").select { |xml_file| File.extname(xml_file) == '.xml' }.each do |xml_file|
  #         # puts "xml_file: #{xml_file}"
  #         filename_date = xml_file.split("/").last.scan(/\d{8}/).first
  #         destination_dir = "#{source_dir}/#{filename_date}"
  #         FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
  #         content_id = File.basename(xml_file, ".xml").split("_").first
  #         received = YhGraphic.find_by(content_id: content_id)
  #         # sudo_passwd = ""
  #         # system("echo #{sudo_passwd} | sudo -S chown apple #{xml_file}")
  #         if File.basename(xml_file, ".xml").split("_").last == "C"
  #           unless received
  #             xml = File.open(xml_file, 'r'){|f| f.read}
  #             picture_hash = YNewsML.parse(xml).to_hash
  #             picture_hash[:content_id] = content_id
  #             YhGraphic.create(picture_hash)
  #             FileUtils.mv(xml_file, destination_dir)
  #           end
  #         else
  #           xml = File.open(xml_file, 'r'){|f| f.read}
  #           picture_hash = YNewsML.parse(xml).to_hash
  #           picture_hash[:content_id] = content_id
  #           YhGraphic.create(picture_hash)
  #           FileUtils.mv(xml_file, destination_dir)
  #         end
  #         # FileUtils.mv(source_file, destination_dir) unless File.exists?(source_file)
  #         left_file = Dir.glob("#{source_dir}/*").count { |xml_file| File.extname(xml_file) == '.xml' }
  #         puts "#{xml_file}...뉴스파일 이동중... #{total_file - left_file}/#{total_file}개 처리"
  #       end
  #     end
  #   end
  # end

  # def self.load_ytn_sample
  #   self.parse_wire_story
  #   self.parse_wire_picture
  #   self.parse_wire_graphic
  # end

  # def self.parse_wire_story
  #   require 'date'
  #   today = Date.today
  #   today_string = today.strftime("%Y%m%d")
  #   directory = "#{Rails.root}/public/wire_source/101_KOR/#{today_string}"
  #   puts "연합뉴스:기사를 가져오고 있습니다"
  #   Dir.glob("#{directory}/*.xml").each do |xml_file|
  #     content_id = File.basename(xml_file, ".xml")
  #     received = YhArticle.find_by(content_id: content_id)
  #     unless received
  #       xml = File.open(xml_file, 'r'){|f| f.read}
  #       story_hash = YNewsML.parse(xml).to_hash
  #       story_hash[:content_id] = content_id
  #       YhArticle.create(story_hash)
  #     end
  #   end
  # end

  # def self.parse_wire_picture
  #   require 'date'
  #   today = Date.today
  #   today_string = today.strftime("%Y%m%d")
  #   directory = "#{Rails.root}/public/wire_source/201_PHOTO_YNA/#{today_string}"
  #   puts "연합뉴스:사진을 가져오고 있습니다"
  #   Dir.glob("#{directory}/*.xml").each do |xml_file|
  #     content_id = File.basename(xml_file, ".xml")
  #     received = YhPicture.find_by(content_id: content_id)
  #     unless received
  #       xml = File.open(xml_file, 'r'){|f| f.read}
  #       picture_hash = YNewsML.parse(xml).to_hash
  #       picture_hash[:content_id] = content_id
  #       YhPicture.create(picture_hash)
  #     end
  #   end
  # end

  # def self.parse_wire_graphic
  #   require 'date'
  #   today = Date.today
  #   today_string = today.strftime("%Y%m%d")
  #   directory = "#{Rails.root}/public/wire_source/203_GRAPHIC/#{today_string}"
  #   puts "연합뉴스:그래픽을 가져오고 있습니다"
  #   Dir.glob("#{directory}/*.xml").each do |xml_file|
  #     content_id = File.basename(xml_file, ".xml")
  #     received = YhGraphic.find_by(content_id: content_id)
  #     unless received
  #       xml = File.open(xml_file, 'r'){|f| f.read}
  #       graphic_hash = YNewsML.parse(xml).to_hash
  #       graphic_hash[:content_id] = content_id
  #       YhGraphic.create(graphic_hash)
  #     end
  #   end
  # end
end
