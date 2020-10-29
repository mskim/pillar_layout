# == Schema Information
#
# Table name: videos
#
#  id               :bigint           not null, primary key
#  height           :decimal(, )
#  player_type      :string
#  source_video_url :string
#  width            :decimal(, )
#  x                :decimal(, )
#  y                :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  web_page_id      :bigint           not null
#
# Indexes
#
#  index_videos_on_web_page_id  (web_page_id)
#
# Foreign Keys
#
#  fk_rails_...  (web_page_id => web_pages.id)
#
require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
