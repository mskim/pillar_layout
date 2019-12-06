# == Schema Information
#
# Table name: ad_plans
#
#  id            :bigint           not null, primary key
#  ad_type       :string
#  advertiser    :string
#  color_page    :boolean
#  comment       :string
#  date          :date
#  page_number   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ad_booking_id :bigint
#
# Indexes
#
#  index_ad_plans_on_ad_booking_id  (ad_booking_id)
#
# Foreign Keys
#
#  fk_rails_...  (ad_booking_id => ad_bookings.id)
#

FactoryBot.define do
  factory :ad_plan do
    date { "2018-12-21" }
    page_number { 1 }
    ad_type { "MyString" }
    advertiser { "MyString" }
    color_page { false }
    comment { "MyString" }
  end
end
