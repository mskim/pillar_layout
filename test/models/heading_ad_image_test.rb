# == Schema Information
#
# Table name: heading_ad_images
#
#  id               :bigint           not null, primary key
#  advertiser       :string
#  date             :date
#  heading_ad_image :string
#  height           :float
#  height_in_unit   :float
#  width            :float
#  width_in_unit    :float
#  x                :float
#  x_in_unit        :float
#  y                :float
#  y_in_unit        :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  page_heading_id  :bigint
#
# Indexes
#
#  index_heading_ad_images_on_page_heading_id  (page_heading_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_heading_id => page_headings.id)
#

require 'test_helper'

class HeadingAdImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
