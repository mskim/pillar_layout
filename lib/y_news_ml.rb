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
#
class CodeCategory
  include HappyMapper
  tag 'Category'

  attribute :code, String, tag: 'code'
  attribute :name, String, tag: 'name'

  def to_hash
    h = {}
    h[:code]     = self.code if self.code
    h[:name]     = self.name if self.name
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
    h[:code]     = self.code if self.code
    h[:name]     = self.name if self.name
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
    h[:code]     = self.code if self.code
    h[:name]     = self.name if self.name
    h
  end
end

class Attribute
  include HappyMapper
  tag 'Attribute'
  has_many :attribute_codes, AttributeCode

  def to_hash
    h = []
    attribute_codes.each do |attribute_code|
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
  has_one :Region, String
  has_one :Class, String, tag: 'Class'
  has_one :Attribute, String, tag: 'Attribute'
  has_one :Credit, String
  has_one :Source, String

  def to_hash
    h = {}
    h[:urgency] = self.Urgency if self.Urgency
    h[:category] = self.Category.to_hash if self.Category
    h[:region] = self.Region if self.Urgency
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
    h[:appenddata]      = self.AppendData if self.AppendData
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

  def self.ytn_101
    @today = Date.today
    @today_string = @today.strftime("%Y%m%d")
    @source = "101_KOR"
    source_dir = "/Volumes/wire_source/yna_contents/YNA_CONTENTS/#{@source}/#{@today_string}"
    self.parse_wire(source_dir)
  end

  def self.ytn_201
    @today = Date.today
    @today_string = @today.strftime("%Y%m%d")
    @source = "201_PHOTO_YNA"
    source_dir = "/Volumes/wire_source/yna_contents/YNA_CONTENTS/#{@source}/#{@today_string}"
    self.parse_wire(source_dir)
  end

  def self.ytn_202
    @today = Date.today
    @today_string = @today.strftime("%Y%m%d")
    @source = "202_PHOTO_TR"
    source_dir = "/Volumes/wire_source/yna_contents/YNA_CONTENTS/#{@source}/#{@today_string}"
    self.parse_wire(source_dir)
  end

  def self.ytn_203
    @today = Date.today
    @today_string = @today.strftime("%Y%m%d")
    @source = "203_GRAPHIC"
    source_dir = "/Volumes/wire_source/yna_contents/YNA_CONTENTS/#{@source}/#{@today_string}"
    self.parse_wire(source_dir)
  end

  def self.ytn_205
    @today = Date.today
    # @today_string = @today.strftime("%Y%m%d")
    @today_string = 20191212
    @source = "205_PHOTO_FR_YNA"
    source_dir = "/Volumes/wire_source/yna_contents/YNA_CONTENTS/#{@source}/#{@today_string}"
    self.parse_wire(source_dir)
  end

  def self.ytn_401
    @today = Date.today
    @today_string = @today.strftime("%Y%m%d")
    @source = "401_PR"
    source_dir = "/Volumes/wire_source/yna_contents/YNA_CONTENTS/#{@source}/#{@today_string}"
    self.parse_wire(source_dir)
  end

 
  def self.parse_wire(source_dir)
    today = Date.today

    if @source == "101_KOR"
      @class = YhArticle
    elsif @source == "202_PHOTO_TR"
      @class = YhPhotoTr
    elsif @source == "201_PHOTO_YNA"
      @class = YhPicture
    elsif @source == "203_GRAPHIC"
      @class = YhGraphic
    elsif @source == "205_PHOTO_FR_YNA"
      @class = YhPhotoFrYna
    elsif @source == "401_PR"
      @class = YhPr
    end

    @class.delete_week_old(today)
    total_file = Dir[File.join(source_dir, '*.xml')].count { |f| File.file?(f) } 
    Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
      if File.extname(source_file) == '.ai' || File.extname(source_file) == '.jpg' || File.extname(source_file) == '.png'
        Dir.glob("#{source_dir}/*").select { |img_file| File.extname(img_file) == '.ai' || File.extname(img_file) == '.jpg' || File.extname(source_file) == '.png' }.each do |img_file|
          filename_date = img_file.split("/").last.scan(/\d{8}/).first
          year_dir = filename_date.scan(/\d{4}/).first
          month_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).first
          day_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).last
          wire_dir = "/Volumes/wire_source/wire_source/#{@source}"
          destination_dir  = "#{wire_dir}/#{year_dir}/#{month_dir}/#{day_dir}"
          # destination_dir = "#{source_dir}/#{filename_date}" 
          puts "#{img_file} ... 이미지 파일 이동중 ..."        
          FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
          if img_file.split("_").last.split(".").first == 'T2'
            FileUtils.mkdir_p "#{destination_dir}/thumb"
            FileUtils.mv(img_file, destination_dir + "/thumb") 
          elsif img_file.split("_").last.split(".").first == 'P1'
            FileUtils.mkdir_p "#{destination_dir}/pre"
            FileUtils.mv(img_file, destination_dir + "/pre") 
          else
            FileUtils.mkdir_p "#{destination_dir}/full"
            FileUtils.mv(img_file, destination_dir + "/full") 
          end
        end
      else
        Dir.glob("#{source_dir}/*").select { |xml_file| File.extname(xml_file) == '.xml' }.each do |xml_file|
          filename_date = xml_file.split("/").last.scan(/\d{8}/).first
          year_dir = filename_date.scan(/\d{4}/).first
          month_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).first
          day_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).last
          wire_dir = "/Volumes/wire_source/wire_source/#{@source}"
          destination_dir  = "#{wire_dir}/#{year_dir}/#{month_dir}/#{day_dir}/xml"
          FileUtils.mkdir_p "#{destination_dir}" unless File.directory?(destination_dir)
          content_id = File.basename(xml_file, ".xml").split("_").first
          received = @class.find_by(content_id: content_id) 
          if @source == "205_PHOTO_FR_YNA"
            if File.basename(xml_file, ".xml").split("_").last == "U"
              if received
                xml = File.open(xml_file, 'r'){|f| f.read}
                picture_hash = YNewsML.parse(xml).to_hash
                picture_hash[:content_id] = content_id
                @class.update(picture_hash)
                # sleep 0.01
                FileUtils.mv(xml_file, destination_dir)
              else
                xml = File.open(xml_file, 'r'){|f| f.read}
                picture_hash = YNewsML.parse(xml).to_hash
                picture_hash[:content_id] = content_id
                @class.create(picture_hash)
                # sleep 0.01
                FileUtils.mv(xml_file, destination_dir)
              end
            else
              xml = File.open(xml_file, 'r'){|f| f.read}
              picture_hash = YNewsML.parse(xml).to_hash
              picture_hash[:content_id] = content_id
              @class.update(picture_hash)
              # sleep 0.01
              FileUtils.mv(xml_file, destination_dir)
            end  
          else
            if File.basename(xml_file, ".xml").split("_").last == "C"
              if received
                xml = File.open(xml_file, 'r'){|f| f.read}
                picture_hash = YNewsML.parse(xml).to_hash
                picture_hash[:content_id] = content_id
                @class.update(picture_hash)
                # sleep 0.01
                FileUtils.mv(xml_file, destination_dir)
              else
                xml = File.open(xml_file, 'r'){|f| f.read}
                picture_hash = YNewsML.parse(xml).to_hash
                picture_hash[:content_id] = content_id
                @class.create(picture_hash)
                # sleep 0.01
                FileUtils.mv(xml_file, destination_dir)
              end
            else
              xml = File.open(xml_file, 'r'){|f| f.read}
              picture_hash = YNewsML.parse(xml).to_hash
              picture_hash[:content_id] = content_id
              @class.update(picture_hash)
              # sleep 0.01
              FileUtils.mv(xml_file, destination_dir)
            end 
          end    
          # FileUtils.mv(xml_file, destination_dir)
          left_file = Dir.glob("#{source_dir}/*").count { |xml_file| File.extname(xml_file) == '.xml' }
          puts "#{xml_file}...뉴스파일 이동중... #{total_file - left_file}/#{total_file}개 처리"    
        end
      end
    end
  end

end
