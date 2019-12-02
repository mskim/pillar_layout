# == Schema Information
#
# Table name: ads
#
#  id             :integer          not null, primary key
#  name           :string
#  column         :integer
#  row            :integer
#  page_columns   :integer
#  publication_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class AdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
