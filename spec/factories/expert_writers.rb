# == Schema Information
#
# Table name: expert_writers
#
#  id               :bigint(8)        not null, primary key
#  name             :string
#  work             :string
#  position         :string
#  email            :string
#  category_code    :string
#  expert_image     :string
#  expert_jpg_image :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :expert_writer do
    name { "MyString" }
    work { "MyString" }
    position { "MyString" }
    email { "MyString" }
    category_code { "MyString" }
    expert_image { "MyString" }
    expert_jpg_image { "MyString" }
  end
end
