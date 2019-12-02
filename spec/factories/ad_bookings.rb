# == Schema Information
#
# Table name: ad_bookings
#
#  id             :bigint(8)        not null, primary key
#  publication_id :bigint(8)
#  date           :date
#  ad_list        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
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
