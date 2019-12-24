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

FactoryBot.define do
  factory :member do
    caption_title { "MyString" }
    caption_description { "MyText" }
    source { "MyString" }
    order { 1 }
  end
end
