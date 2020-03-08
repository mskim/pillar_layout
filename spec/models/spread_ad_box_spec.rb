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

require 'rails_helper'

RSpec.describe SpreadAdBox, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
