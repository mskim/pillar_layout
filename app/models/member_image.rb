# frozen_string_literal: true

# == Schema Information
#
# Table name: member_images
#
#  id             :bigint           not null, primary key
#  caption        :string
#  order          :integer
#  source         :string
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  group_image_id :bigint           not null
#
# Indexes
#
#  index_member_images_on_group_image_id  (group_image_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_image_id => group_images.id)
#

class MemberImage < ApplicationRecord
  # belongs_to
  belongs_to :group_image

  # has_one_attached
  has_one_attached :image_attach
end
