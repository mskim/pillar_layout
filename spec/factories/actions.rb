# == Schema Information
#
# Table name: actions
#
#  id         :bigint           not null, primary key
#  actions    :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :action do
    name { "MyString" }
    actions { "MyText" }
  end
end
