# == Schema Information
#
# Table name: ad_plans
#
#  id            :bigint(8)        not null, primary key
#  date          :date
#  page_number   :integer
#  ad_type       :string
#  advertiser    :string
#  color_page    :boolean
#  comment       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ad_booking_id :bigint(8)
#
# Indexes
#
#  index_ad_plans_on_ad_booking_id  (ad_booking_id)
#
# Foreign Keys
#
#  fk_rails_...  (ad_booking_id => ad_bookings.id)
#

require 'rails_helper'

RSpec.describe AdPlan, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
