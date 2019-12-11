# == Schema Information
#
# Table name: wire_stories
#
#  id            :bigint           not null, primary key
#  body          :text
#  category_code :string
#  category_name :string
#  credit        :string
#  region_code :string
#  region_name :string
#  send_date     :date
#  source        :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  content_id    :string
#  issue_id      :bigint
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
