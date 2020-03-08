# == Schema Information
#
# Table name: sections
#
#  id                           :integer          not null, primary key
#  ad_type                      :string
#  article_line_thickness       :float
#  bottom_margin                :float
#  color_page                   :boolean          default(FALSE)
#  column                       :integer
#  draw_divider                 :boolean
#  grid_height                  :float
#  grid_width                   :float
#  gutter                       :float
#  height                       :float
#  is_front_page                :boolean
#  layout                       :text
#  left_margin                  :float
#  lines_per_grid               :float
#  order                        :integer
#  page_heading_margin_in_lines :integer
#  page_number                  :integer
#  path                         :string
#  profile                      :string
#  right_margin                 :float
#  row                          :integer
#  section_name                 :string
#  story_count                  :integer
#  top_margin                   :float
#  width                        :float
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  publication_id               :integer          default(1)
#


require 'rails_helper'

RSpec.describe Section, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
