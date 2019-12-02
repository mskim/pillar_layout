# == Schema Information
#
# Table name: sections
#
#  id                           :integer          not null, primary key
#  profile                      :string
#  column                       :integer
#  row                          :integer
#  order                        :integer
#  ad_type                      :string
#  is_front_page                :boolean
#  story_count                  :integer
#  page_number                  :integer
#  section_name                 :string
#  color_page                   :boolean          default(FALSE)
#  publication_id               :integer          default(1)
#  layout                       :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  draw_divider                 :boolean
#  path                         :string
#  grid_width                   :float
#  grid_height                  :float
#  lines_per_grid               :float
#  width                        :float
#  height                       :float
#  left_margin                  :float
#  top_margin                   :float
#  right_margin                 :float
#  bottom_margin                :float
#  gutter                       :float
#  page_heading_margin_in_lines :integer
#  article_line_thickness       :float
#

require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
