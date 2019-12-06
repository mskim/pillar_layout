# == Schema Information
#
# Table name: graphics
#
#  id                    :bigint           not null, primary key
#  caption               :string
#  column                :integer
#  description           :text
#  detail_mode           :boolean
#  draw_frame            :boolean          default(FALSE)
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

require 'rails_helper'

RSpec.describe Graphic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
