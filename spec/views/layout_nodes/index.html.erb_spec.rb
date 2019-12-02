require 'rails_helper'

RSpec.describe "layout_nodes/index", type: :view do
  before(:each) do
    assign(:layout_nodes, [
      LayoutNode.create!(
        :direction => "Direction",
        :grid_x => 2,
        :grid_y => 3,
        :column => 4,
        :row => 5,
        :profile => "Profile",
        :node_kind => "Node Kind",
        :tag => "Tag",
        :selected => false,
        :actions => "MyText",
        :layout => "MyText",
        :layout_with_pillar_path => "MyText",
        :box_count => 6
      ),
      LayoutNode.create!(
        :direction => "Direction",
        :grid_x => 2,
        :grid_y => 3,
        :column => 4,
        :row => 5,
        :profile => "Profile",
        :node_kind => "Node Kind",
        :tag => "Tag",
        :selected => false,
        :actions => "MyText",
        :layout => "MyText",
        :layout_with_pillar_path => "MyText",
        :box_count => 6
      )
    ])
  end

  it "renders a list of layout_nodes" do
    render
    assert_select "tr>td", :text => "Direction".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Profile".to_s, :count => 2
    assert_select "tr>td", :text => "Node Kind".to_s, :count => 2
    assert_select "tr>td", :text => "Tag".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
