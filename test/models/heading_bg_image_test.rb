# == Schema Information
#
# Table name: heading_bg_images
#
#  id               :bigint           not null, primary key
#  heading_bg_image :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  page_heading_id  :bigint
#
# Indexes
#
#  index_heading_bg_images_on_page_heading_id  (page_heading_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_heading_id => page_headings.id)
#

require 'test_helper'

class HeadingBgImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
