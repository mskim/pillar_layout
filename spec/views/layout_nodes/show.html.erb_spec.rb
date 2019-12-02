require 'rails_helper'

RSpec.describe "layout_nodes/show", type: :view do
  before(:each) do
    @layout_node = assign(:layout_node, LayoutNode.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Direction/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Profile/)
    expect(rendered).to match(/Node Kind/)
    expect(rendered).to match(/Tag/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/6/)
  end
end
