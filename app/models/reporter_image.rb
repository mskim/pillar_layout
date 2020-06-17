# frozen_string_literal: true

# == Schema Information
#
# Table name: reporter_images
#
#  id             :bigint           not null, primary key
#  caption        :string
#  kind           :string
#  reporter_image :string
#  section_name   :string
#  source         :string
#  title          :string
#  used_in_layout :boolean
#  wire_pictures  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_reporter_images_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class ReporterImage < ApplicationRecord
  belongs_to :user
  mount_uploader :reporter_image, ReporterImageUploader

  validates_uniqueness_of :title

  def self.image_from_wire(user, wire, kind)
    s = ReporterImage.where(user_id: user.id, wire_pictures: wire.picture).first_or_create!
    s.title           = wire.title
    s.caption         = wire.body
    # s.caption         = wire.body.gsub("\r\n", " ").gsub("  ", " ")
    s.source          = wire.source
    s.wire_pictures   = wire.picture
    s.kind            = kind
    s.save
  end

  # TODO
  def source_path
    return unless wire_pictures

    # full_size = wire_pictures.split(" ").first
    filename_date = wire_pictures.split('.').first.scan(/\d{3,8}/).first
    i = ReporterImage.find(id)
    # if i.source == "YNA"
    #   "/wire_source/201_PHOTO_YNA/#{@filename_date}"
    # elsif i.source == "RU" || i.source == "AP"
    #   "/wire_source/202_PHOTO_TR/#{@filename_date}"
    # else
    #   "/wire_source/205_PHOTO_FR_YNA/#{@filename_date}"
    # end
    year_dir = filename_date.scan(/\d{4}/).first
    month_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).first
    day_dir = filename_date.scan(/\d{4}/).last.scan(/\d{2}/).last

    filename_code = wire_pictures.split('.').first.scan(/\d{4,4}/).last
    if filename_code == '0001' || filename_code == '0007' || filename_code == '0006'
      "/wire_source/201_PHOTO_YNA/#{year_dir}/#{month_dir}/#{day_dir}"
    elsif filename_code == '0440'
      "/wire_source/203_GRAPHIC/#{year_dir}/#{month_dir}/#{day_dir}"
    elsif filename_code == '0184'
      "/wire_source/205_PHOTO_FR_YNA/#{year_dir}/#{month_dir}/#{day_dir}"
    else
      "/wire_source/202_PHOTO_TR/#{year_dir}/#{month_dir}/#{day_dir}"
    end
    # "/wire_source/201_PHOTO_YNA/"
  end

  def full_size_path
    return unless wire_pictures
    full_size = wire_pictures.split(' ').first
    source_path + "/full/#{full_size}"
  end

  def filter_cation
    filtered_caption = caption.gsub("\n\r", " ")
    filtered_caption = cation.gsub("  ", " ")
    update(caption: filtered_caption)
  end

  def preview_path
    return unless wire_pictures

    preview = wire_pictures.split(' ')[1]
    source_path + "/pre/#{preview}"
  end

  def thumb_path
    return unless wire_pictures

    thumb = wire_pictures.split(' ').last
    source_path + "/thumb/#{thumb}"
  end
end
