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
#
# Indexes
#
#  index_layout_nodes_on_pillar_id  (pillar_id)
#

FactoryBot.define do
  factory :layout_node do
    direction { "MyString" }
    grid_x { 1 }
    grid_y { 1 }
    column { 1 }
    row { 1 }
    profile { "MyString" }
    node_kind { "MyString" }
    tag { "MyString" }
    selected { false }
    actions { "MyText" }
    layout { "MyText" }
    layout_with_pillar_path { "MyText" }
    box_count { 1 }
  end
end
