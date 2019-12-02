# == Schema Information
#
# Table name: articles
#
#  id                           :integer          not null, primary key
#  grid_x                       :integer
#  grid_y                       :integer
#  column                       :integer
#  row                          :integer
#  order                        :integer
#  kind                         :string
#  profile                      :integer
#  title_head                   :string
#  title                        :text
#  subtitle                     :text
#  subtitle_head                :text
#  body                         :text
#  reporter                     :string
#  email                        :string
#  personal_image               :string
#  image                        :string
#  quote                        :text
#  subject_head                 :string
#  on_left_edge                 :boolean
#  on_right_edge                :boolean
#  is_front_page                :boolean
#  top_story                    :boolean
#  top_position                 :boolean
#  section_id                   :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  extended_line_count          :integer
#  pushed_line_count            :integer
#  publication_name             :string
#  path                         :string
#  page_heading_margin_in_lines :integer
#  grid_width                   :float
#  grid_height                  :float
#  gutter                       :float
#  overlap                      :text
#  embedded                     :boolean
#  y_in_lines                   :integer
#  height_in_lines              :integer
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
