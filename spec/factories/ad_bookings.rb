# == Schema Information
#
# Table name: ad_bookings
#
#  id             :bigint           not null, primary key
#  ad_list        :text
#  date           :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint
#
# Indexes
#
#  index_ad_bookings_on_publication_id  (publication_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#

FactoryBot.define do
  factory :ad_booking do
    publication { nil }
    date { "2019-01-10" }
    ad_list { "MyText" }
  end
end
