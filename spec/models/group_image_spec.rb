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

require 'rails_helper'

RSpec.describe GroupImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
