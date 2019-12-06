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

require 'rails_helper'

RSpec.describe AdBooking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
