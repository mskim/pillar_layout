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

require 'rails_helper'

RSpec.describe LayoutNode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
