# frozen_string_literal: true

# == Schema Information
#
# Table name: member_images
#
#  id                 :bigint           not null, primary key
#  caption            :string
#  member_img         :string
#  order              :integer
#  source             :string
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  working_article_id :bigint           not null
#
# Indexes
#
#  index_member_images_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

class MemberImage < ApplicationRecord
  # CarrierWave
  mount_uploader :member_img, MemberImgUploader

  # belongs_to
  belongs_to :working_article

  # has_one_attached
  has_one_attached :image_attach

  # 사진순서 중복제거 검증
  # validates_uniqueness_of :order

  def modal_title
    title.split(' ').join('')
  end
end
