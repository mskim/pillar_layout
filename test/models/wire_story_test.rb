# == Schema Information
#
# Table name: wire_stories
#
#  id            :bigint(8)        not null, primary key
#  send_date     :date
#  content_id    :string
#  category_code :string
#  category_name :string
#  region_code   :string
#  region_name   :string
#  credit        :string
#  source        :string
#  title         :string
#  body          :text
#  issue_id      :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_wire_stories_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#

require 'test_helper'

class WireStoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
