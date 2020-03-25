# == Schema Information
#
# Table name: working_articles
#
#  id                           :integer          not null, primary key
#  announcement_color           :string
#  announcement_column          :integer
#  announcement_text            :string
#  body                         :text
#  bottom_line                  :integer          default("0")
#  boxed_subtitle_text          :string
#  boxed_subtitle_type          :integer
#  by_line                      :string
#  category_code                :integer
#  category_name                :string
#  column                       :integer
#  date                         :date
#  email                        :string
#  embedded                     :boolean
#  extended_line_count          :integer
#  frame_color                  :string
#  frame_sides                  :string
#  frame_thickness              :float
#  grid_height                  :float
#  grid_width                   :float
#  grid_x                       :integer
#  grid_y                       :integer
#  gutter                       :float
#  has_profile_image            :boolean
#  heading_columns              :integer
#  height_in_lines              :integer
#  image                        :string
#  inactive                     :boolean
#  is_front_page                :boolean
#  kind                         :string
#  left_line                    :integer          default("0")
#  on_left_edge                 :boolean
#  on_right_edge                :boolean
#  order                        :integer
#  overlap                      :text
#  page_heading_margin_in_lines :integer
#  page_number                  :integer
#  path                         :string
#  pillar_order                 :string
#  price                        :float
#  profile                      :string
#  publication_name             :string
#  pushed_line_count            :integer
#  quote                        :text
#  quote_alignment              :string
#  quote_box_column             :integer
#  quote_box_show               :boolean
#  quote_box_size               :integer
#  quote_box_type               :integer
#  quote_line_type              :string
#  quote_position               :integer
#  quote_v_extra_space          :integer
#  quote_x_grid                 :integer
#  reporter                     :string
#  right_line                   :integer          default("0")
#  row                          :integer
#  slug                         :string
#  subcategory_code             :string
#  subject_head                 :string
#  subtitle                     :text
#  subtitle_head                :string
#  subtitle_type                :string
#  title                        :text
#  title_head                   :string
#  top_line                     :integer          default("0")
#  top_position                 :boolean
#  top_story                    :boolean
#  y_in_lines                   :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  article_id                   :integer
#  page_id                      :integer
#  pillar_id                    :bigint
#
# Indexes
#
#  index_working_articles_on_article_id  (article_id)
#  index_working_articles_on_page_id     (page_id)
#  index_working_articles_on_pillar_id   (pillar_id)
#  index_working_articles_on_slug        (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (pillar_id => pillars.id)
#

require_relative '../test_helper'

class WorkingArticleTest < ActiveSupport::TestCase
  test "calculate_fitting_image_size" do
    assert true
  end
end
