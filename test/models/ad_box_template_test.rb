# == Schema Information
#
# Table name: ad_box_templates
#
#  id         :integer          not null, primary key
#  grid_x     :integer
#  grid_y     :integer
#  column     :integer
#  row        :integer
#  order      :integer
#  ad_type    :string
#  section_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AdBoxTemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
