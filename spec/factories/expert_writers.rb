# == Schema Information
#
# Table name: expert_writers
#
#  id               :bigint           not null, primary key
#  category_code    :string
#  email            :string
#  expert_image     :string
#  expert_jpg_image :string
#  name             :string
#  position         :string
#  work             :string
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
