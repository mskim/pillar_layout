# == Schema Information
#
# Table name: combo_ads
#
#  id         :bigint(8)        not null, primary key
#  base_ad    :string
#  column     :integer
#  row        :integer
#  layout     :text
#  profile    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :combo_ad do
    base_ad { "MyString" }
    column { 1 }
    row { 1 }
    layout { "MyText" }
    profile { "MyString" }
  end
end
