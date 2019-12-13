# frozen_string_literal: true

# == Schema Information
#
# Table name: yh_pictures
#
#  id              :bigint           not null, primary key
#  action          :string
#  attriubute_code :string
#  body            :string
#  category        :string
#  class_code      :string
#  comment         :string
#  credit          :string
#  date            :date
#  picture         :string
#  region          :string
#  service_type    :string
#  source          :string
#  taken_by        :string
#  time            :time
#  title           :string
#  urgency         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  content_id      :string
#

class YhPicture < ApplicationRecord
  establish_connection :wire_service
  validates_uniqueness_of :content_id

  def source_path
    require 'date'
    today = Date.today
    today_string = today.strftime("%Y%m%d")
    filename_date = content_id.split("/").last.scan(/\d{8}/).first
    year_dir = filename_date.scan(/\d{4}/).first
    month_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).first
    day_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).last
    "/wire_source/201_PHOTO_YNA/#{year_dir}/#{month_dir}/#{day_dir}"

    # source_dir = "/wire_source/201_PHOTO_YNA/#{@filename_date}"
    # Dir.glob("#{source_dir}/*").select { |source_file| File.file?(source_file) }.each do |source_file|
    # @filename_date = source_file.split("/").last.scan(/\d{8}/).first

    # "/Volumes/211.115.91.190/201_PHOTO_YNA/#{Issue.last.date_string}"
  end

  def full_size_path
    return unless picture

    full_size = picture.split(' ').first
    source_path + "/full/#{full_size}"
  end

  def preview_path
    return unless picture

    preview = picture.split(' ')[1]
    source_path + "/pre/#{preview}"
  end

  def thumb_path
    return unless picture

    thumb = picture.split(' ').last
    source_path + "/thumb/#{thumb}"
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
