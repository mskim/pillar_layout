# == Schema Information
#
# Table name: layout_nodes
#
#  id                      :bigint           not null, primary key
#  actions                 :text
#  ancestry                :string
#  box_count               :integer
#  column                  :integer
#  direction               :string
#  grid_x                  :integer
#  grid_y                  :integer
#  layout_with_pillar_path :text
#  node_kind               :string
#  order                   :integer
#  profile                 :string
#  row                     :integer
#  selected                :boolean
#  tag                     :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  pillar_id               :bigint
#  working_article_id      :integer
#
# Indexes
#
#  index_layout_nodes_on_pillar_id  (pillar_id)
#

require 'rails_helper'

RSpec.describe LayoutNode, type: :model do
  it "is valid with valid attributes"
  it "is not valid without a grid_x"
  it "is not valid without a grid_y"
  it "is not valid without a column"
  it "is not valid without a row"
end
