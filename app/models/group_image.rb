# frozen_string_literal: true

# == Schema Information
#
# Table name: group_images
#
#  id                  :bigint           not null, primary key
#  caption_description :text
#  caption_title       :string
#  caption_type        :string
#  direction           :string
#  position            :integer
#  source              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class GroupImage < ApplicationRecord
  # belongs_to
  belongs_to :working_article
  # has_many
  has_many :members, dependent: :destroy
  # has_one

  accepts_nested_attributes_for :members
end
