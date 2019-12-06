# == Schema Information
#
# Table name: spreads
#
#  id            :bigint           not null, primary key
#  bottom_margin :float
#  color_page    :boolean
#  height        :float
#  left_margin   :float
#  page_gutter   :float
#  right_margin  :float
#  top_margin    :float
#  width         :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ad_box_id     :integer
#  issue_id      :bigint
#  left_page_id  :integer
#  right_page_id :integer
#
# Indexes
#
#  index_spreads_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#

require 'rails_helper'

RSpec.describe Spread, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
