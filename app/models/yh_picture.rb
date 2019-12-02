# frozen_string_literal: true

# == Schema Information
#
# Table name: yh_pictures
#
#  id              :bigint(8)        not null, primary key
#  action          :string
#  service_type    :string
#  content_id      :string
#  date            :date
#  time            :time
#  urgency         :string
#  category        :string
#  class_code      :string
#  attriubute_code :string
#  source          :string
#  credit          :string
#  region          :string
#  title           :string
#  comment         :string
#  body            :string
#  picture         :string
#  taken_by        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class YhPicture < ApplicationRecord
  validates_uniqueness_of :content_id

  def source_path
    require 'date'
    today = Date.today
    today_string = today.strftime('%Y%m%d')
    @filename_date = content_id.split('/').last.scan(/\d{8}/).first
    "/wire_source/201_PHOTO_YNA/#{@filename_date}"

    # source_dir = "/wire_source/201_PHOTO_YNA/#{@filename_date}"
    # Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
    # @filename_date = source_file.split("/").last.scan(/\d{8}/).first

    # "/Volumes/211.115.91.190/201_PHOTO_YNA/#{Issue.last.date_string}"
  end

  def full_size_path
    return unless picture

    full_size = picture.split(' ').first
    source_path + "/#{full_size}"
  end

  def preview_path
    return unless picture

    preview = picture.split(' ')[1]
    source_path + "/#{preview}"
  end

  def thumb_path
    return unless picture

    thumb = picture.split(' ').last
    source_path + "/#{thumb}"
  end

  def taken(user)
    self.taken_by = user.name
    save
  end

  def self.delete_week_old(today)
    one_week_old = today.days_ago(3)
    YhPicture.all.each do |picture|
      picture.destroy if picture.created_at < one_week_old
    end
  end
end
