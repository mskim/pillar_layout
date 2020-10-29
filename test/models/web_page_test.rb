# == Schema Information
#
# Table name: web_pages
#
#  id            :bigint           not null, primary key
#  current_tool  :string
#  height        :decimal(, )
#  page_number   :integer
#  text_content  :text
#  text_position :integer
#  toc           :boolean
#  width         :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  issue_id      :bigint           not null
#
# Indexes
#
#  index_web_pages_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#
require 'test_helper'

class WebPageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
