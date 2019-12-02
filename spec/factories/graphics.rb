# == Schema Information
#
# Table name: graphics
#
#  id                    :bigint(8)        not null, primary key
#  grid_x                :integer
#  grid_y                :integer
#  column                :integer
#  row                   :integer
#  extra_height_in_lines :integer
#  graphic               :string
#  caption               :string
#  source                :string
#  position              :string
#  page_number           :integer
#  story_number          :integer
#  working_article_id    :bigint(8)
#  issue_id              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  x_grid                :integer
#  y_in_lines            :integer
#  height_in_lines       :integer
#  draw_frame            :boolean          default(FALSE)
#  detail_mode           :boolean
#  zoom_level            :integer
#  zoom_direction        :integer
#  move_level            :integer
#  sub_grid_size         :string
#  fit_type              :string
#  title                 :string
#  description           :text
#  reporter_graphic_path :string
#
# Indexes
#
#  index_graphics_on_working_article_id  (working_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (working_article_id => working_articles.id)
#

FactoryBot.define do
  factory :graphic do
    grid_x { 1 }
    grid_y { 1 }
    column { 1 }
    row { 1 }
    extra_height_in_lines { 1 }
    graphic { "MyString" }
    caption { "MyString" }
    source { "MyString" }
    position { "MyString" }
    page_number { 1 }
    story_number { 1 }
    working_article { nil }
    issue_id { 1 }
  end
end
