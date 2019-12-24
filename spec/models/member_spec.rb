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

require 'rails_helper'

RSpec.describe Member, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
