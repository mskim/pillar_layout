# frozen_string_literal: true

# == Schema Information
#
# Table name: member_images
#
#  id             :bigint           not null, primary key
#  caption        :string
#  member_img     :string
#  order          :integer
#  source         :string
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  group_image_id :integer
#

class MemberImage < ApplicationRecord
  # before_create :set_new_order

  # CarrierWave
  # mount_uploader :member_img, MemberImgUploader
  belongs_to :group_image

  # has_one_attached :image_attach
  # TODO chnage to this has_one_attached :storage_member_image

  # 사진순서 중복제거 검증
  # validates_uniqueness_of :order

  def modal_title
    title.split(' ').join('')
  end

  def re_order_images(changing_image)
    position = changing_image.order
    working_article.member_images.sort_by{|i| i.order}.each_with_index do |member_image, i|
    # changing_image 보다 뒤에 것 들 order += 1
      if member_image.order < position
      elsif member_image.order == position
        next if member_image == changing_image # 바뀐거 자체일 경우
        member_image.order = i + 2
      else # member_image.order > position
        member_image.order = i + 2
      end
    end
  end

  def layout_rb
    "  image(image_path:'#{member_img}', layout_expand:[:width, :height])\n"
  end

  def info_hash
    h = {}
    h[:image_path]  = member_img
    h[:order]       = order
    h[:title]       = title   if title
    h[:caption]     = caption if caption
    h[:source]      = source  if source
    h
  end

  private

  def set_new_order
    member_images = group_image.member_images
    current_order = member_images.count
    self.order = current_order + 1
  end
end
