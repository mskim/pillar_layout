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

FactoryBot.define do
  factory :group_image do
    caption_title { "MyString" }
    caption_description { "MyText" }
    source { "MyString" }
    position { 1 }
    direction { "MyString" }
  end
end
