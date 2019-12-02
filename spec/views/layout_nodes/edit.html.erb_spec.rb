require 'rails_helper'

RSpec.describe "layout_nodes/edit", type: :view do
  before(:each) do
    @layout_node = assign(:layout_node, LayoutNode.create!(
      :direction => "MyString",
      :grid_x => 1,
      :grid_y => 1,
      :column => 1,
      :row => 1,
      :profile => "MyString",
      :node_kind => "MyString",
      :tag => "MyString",
      :selected => false,
      :actions => "MyText",
      :layout => "MyText",
      :layout_with_pillar_path => "MyText",
      :box_count => 1
    ))
  end

  it "renders the edit layout_node form" do
    render

    assert_select "form[action=?][method=?]", layout_node_path(@layout_node), "post" do

      assert_select "input[name=?]", "layout_node[direction]"

      assert_select "input[name=?]", "layout_node[grid_x]"

      assert_select "input[name=?]", "layout_node[grid_y]"

      assert_select "input[name=?]", "layout_node[column]"

      assert_select "input[name=?]", "layout_node[row]"

      assert_select "input[name=?]", "layout_node[profile]"

      assert_select "input[name=?]", "layout_node[node_kind]"

      assert_select "input[name=?]", "layout_node[tag]"

      assert_select "input[name=?]", "layout_node[selected]"

      assert_select "textarea[name=?]", "layout_node[actions]"

      assert_select "textarea[name=?]", "layout_node[layout]"

      assert_select "textarea[name=?]", "layout_node[layout_with_pillar_path]"

      assert_select "input[name=?]", "layout_node[box_count]"
    end
  end
end
