# frozen_string_literal: true

# == Schema Information
#
# Table name: yh_photo_fr_ynas
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
#  region        :string
#  picture         :string
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

class YhPhotoFrYna < ApplicationRecord
  establish_connection :wire_service
  validates_uniqueness_of :content_id

  def source_path
    require 'date'
    today = Date.today

    today_string = today.strftime('%Y%m%d')
    @filename_date = content_id.split('/').last.scan(/\d{8}/).first
    "/wire_source/205_PHOTO_FR_YNA/#{@filename_date}"
    # "/Volumes/211.115.91.190/101_KOR/#{Issue.last.date_string}"
    # "/Volumes/211.115.91.190/203_GRAPHIC/#{Issue.last.date_string}"
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
    YhPhotoFrYna.all.each do |photo_fr_yna|
      photo_fr_yna.destroy if photo_fr_yna.created_at < one_week_old
    end
  end
end
