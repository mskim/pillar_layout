# == Schema Information
#
# Table name: section_headings
#
#  id             :bigint(8)        not null, primary key
#  page_number    :integer
#  section_name   :string
#  date           :string
#  layout         :text
#  publication_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class SectionHeadingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
