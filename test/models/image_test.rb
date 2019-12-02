# == Schema Information
#
# Table name: images
#
#  id                    :integer          not null, primary key
#  column                :integer
#  row                   :integer
#  extra_height_in_lines :integer          default(0)
#  image                 :string
#  caption_title         :string
#  caption               :string
#  source                :string
#  position              :integer
#  page_number           :integer
#  story_number          :integer
#  landscape             :boolean
#  used_in_layout        :boolean
#  working_article_id    :integer
#  issue_id              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  extra_line            :integer
#  x_grid                :integer
#  y_in_lines            :integer
#  height_in_lines       :integer
#  draw_frame            :boolean          default(TRUE)
#  zoom_level            :integer          default(1)
#  zoom_direction        :integer          default(5)
#  move_level            :integer
#  auto_size             :integer
#  fit_type              :string
#  image_kind            :string
#  not_related           :boolean
#  reporter_image_path   :string
#  crop_x                :integer
#  crop_y                :integer
#  crop_w                :integer
#  crop_h                :integer
#

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
