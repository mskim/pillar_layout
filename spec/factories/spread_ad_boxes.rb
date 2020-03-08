# == Schema Information
#
# Table name: spread_ad_boxes
#
#  id         :bigint           not null, primary key
#  ad_type    :string
#  advertiser :string
#  height     :float
#  row        :integer
#  width      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  spread_id  :bigint           not null
#
# Indexes
#
#  index_spread_ad_boxes_on_spread_id  (spread_id)
#
# Foreign Keys
#
#  fk_rails_...  (spread_id => spreads.id)
#

FactoryBot.define do
  factory :spread_ad_box do
    ad_type { "MyString" }
    advertiser { "MyString" }
    row { 1 }
    width { 1.5 }
    height { 1.5 }
    spread { nil }
  end
end
