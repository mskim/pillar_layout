# == Schema Information
#
# Table name: ad_boxes
#
#  id                           :integer          not null, primary key
#  grid_x                       :integer
#  grid_y                       :integer
#  column                       :integer
#  row                          :integer
#  order                        :integer
#  ad_type                      :string
#  advertiser                   :string
#  inactive                     :boolean
#  ad_image                     :string
#  page_id                      :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  color                        :boolean
#  path                         :string
#  date                         :date
#  page_heading_margin_in_lines :integer
#  page_number                  :integer
#  grid_width                   :float
#  grid_height                  :float
#  gutter                       :float
#
# Indexes
#
#  index_ad_boxes_on_page_id  (page_id)
#

require 'test_helper'

class AdBoxTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
