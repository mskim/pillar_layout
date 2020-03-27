# == Schema Information
#
# Table name: images
#
#  id                    :integer          not null, primary key
#  auto_size             :integer
#  bottom_line           :integer          default(0)
#  caption               :string
#  caption_title         :string
#  column                :integer
#  crop_h                :integer
#  crop_w                :integer
#  crop_x                :integer
#  crop_y                :integer
#  draw_frame            :boolean          default(TRUE)
#  extra_height_in_lines :integer          default(0)
#  extra_line            :integer
#  fit_type              :string
#  height_in_lines       :integer
#  image                 :string
#  image_kind            :string
#  landscape             :boolean
#  left_line             :integer          default(0)
#  move_level            :integer
#  not_related           :boolean
#  page_number           :integer
#  position              :integer
#  reporter_image_path   :string
#  right_line            :integer          default(0)
#  row                   :integer
#  source                :string
#  story_number          :integer
#  top_line              :integer          default(0)
#  used_in_layout        :boolean
#  x_grid                :integer
#  y_in_lines            :integer
#  zoom_direction        :integer          default(5)
#  zoom_level            :integer          default(1)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  issue_id              :integer
#  working_article_id    :integer
#

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
