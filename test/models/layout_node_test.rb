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
require 'test_helper'

class LayoutNodeTest < ActiveSupport::TestCase
  test "create LayoutNode class" do
    node = layout_nodes(:one)
    assert_equal node.class, LayoutNode
  end
end
