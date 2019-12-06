# == Schema Information
#
# Table name: story_categories
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :story_category do
    name { "MyString" }
    code { "MyString" }
  end
end
