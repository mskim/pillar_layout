# == Schema Information
#
# Table name: section_headings
#
#  id             :bigint           not null, primary key
#  date           :string
#  layout         :text
#  page_number    :integer
#  section_name   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :integer
#

require 'test_helper'

class SectionHeadingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
