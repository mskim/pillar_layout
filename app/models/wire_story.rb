# == Schema Information
#
# Table name: wire_stories
#
#  id            :bigint(8)        not null, primary key
#  send_date     :date
#  content_id    :string
#  category_code :string
#  category_name :string
#  region_code   :string
#  region_name   :string
#  credit        :string
#  source        :string
#  title         :string
#  body          :text
#  issue_id      :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_wire_stories_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#

class WireStory < ApplicationRecord
  belongs_to :issue
  after_create :parse_wire_story

  def self.date_string
    Date.today.strftime("%Y%m%d")
  end

  def self.parse_story_for_today
    Dir.glob("#{wire_story_folder}").each do |story|
      puts story
    end
  end

  def self.parse_wire_story
    # l = Dir.glob("/Volumes/211.115.91.190/101_KOR/20180621/*.xml").each do |story|
    #   puts story
    # end
    l = Dir.glob("/Volumes/211.115.91.190/101_KOR/20180621/*.xml")
    puts l.length
  end

  def date_string
    issue.date.strfdate("%Y%m%d")
  end

  def wire_story_folder
    "/Volumes/211.115.91.190/101_KOR/#{date_string}"
    "/Volumes/211.115.91.190/101_KOR/20180621"
  end

  def parse_wire_story
    Dir.glob("#{wire_story_folder}").each do |story|
      puts story
    end
  end

  def self.parse_sample
    require 'rexml/document'
    include REXML
    wire_story_sample_path = "#{Rails.root}/public/1/wire_story/AKR20180620129600005_C.xml"
    wire_story_xml = File.open(wire_story_sample_path, 'r'){|f| f.read}
    doc = Document.new(wire_story_xml)
    data_h = {}
    doc.elements.each("YNewsML/Header") do |element|
      element.children.each do |ch|
        if ch.class == REXML::Element
          data_h[ch.name] = ch.text
        end
      end
    end

    doc.elements.each("YNewsML/Metadata") do |element|
      element.children.each do |ch|
        if ch.class == REXML::Element
          puts "+++++++ ch.name:#{ch.name}"
          puts "+++++++ ch.class:#{ch.class}"

          if ch.name == "Class"
            puts "we have Class"
          elsif ch.name == "Region"
            puts "we have Region"
          elsif ch.name == "Category"
            puts "we have Category"
          else
            data_h[ch.name] = ch.text
          end
        else
          puts "xxxx ch.class:#{ch.class}"
          puts "xxxx ch:#{ch}"

        end

      end
    end

    doc.elements.each("YNewsML/NewsContent") do |element|
      element.children.each do |ch|
        if ch.class == REXML::Element
          data_h[ch.name] = ch.text
        end
      end
    end
    # puts data_h

  end
end
