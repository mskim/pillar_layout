# == Schema Information
#
# Table name: table_styles
#
#  id             :bigint           not null, primary key
#  category_level :integer
#  column         :integer
#  heading_level  :integer
#  layout         :text
#  name           :string
#  row            :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'test_helper'

class TableStyleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
