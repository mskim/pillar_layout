# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id                  :bigint           not null, primary key
#  caption_description :text
#  caption_title       :string
#  order               :integer
#  source              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  group_image_id      :integer
#

class Member < ApplicationRecord
  # belongs_to
  belongs_to :group_image, optional: true
  # has_many
  # has_one
  # has_one_attached
  has_one_attached :image
end
