# == Schema Information
#
# Table name: graphics
#
#  id                    :bigint           not null, primary key
#  caption               :string
#  column                :integer
#  description           :text
#  detail_mode           :boolean
#  draw_frame            :boolean          default("false")
#  extra_height_in_lines :integer
#  fit_type              :string
#  graphic               :string
#  grid_x                :integer
#  grid_y                :integer
#  height_in_lines       :integer
#  move_level            :integer
#  page_number           :integer
#  position              :string
#  reporter_graphic_path :string
#  row                   :integer
#  source                :string
#  story_number          :integer
#  sub_grid_size         :string
#  title                 :string
#  x_grid                :integer
#  y_in_lines            :integer
#  zoom_direction        :integer
#  zoom_level            :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  issue_id              :integer
#  working_article_id    :bigint
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
