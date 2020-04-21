require 'test_helper'

class LayoutNodeTest < ActiveSupport::TestCase
  test "create LayoutNode class" do
    node = layout_nodes(:one)
    assert_equal node.class, LayoutNode
  end
end
