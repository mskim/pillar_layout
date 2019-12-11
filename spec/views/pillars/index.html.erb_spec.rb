require 'rails_helper'

RSpec.describe "pillars/index", type: :view do
  before(:each) do
    assign(:pillars, [
      Pillar.create!(
        :grid_x => 2,
        :grid_y => 3,
        :column => 4,
        :row => 5,
        :order => 6,
        :box_count => 7,
        :layout_with_pillar_path => "MyText",
        :layout => "MyText",
        :profile => "Profile",
        :finger_print => "Finger Print",
        :page_ref => nil,
        :page_ref_type => "page_ref Type"
      ),
      Pillar.create!(
        :grid_x => 2,
        :grid_y => 3,
        :column => 4,
        :row => 5,
        :order => 6,
        :box_count => 7,
        :layout_with_pillar_path => "MyText",
        :layout => "MyText",
        :profile => "Profile",
        :finger_print => "Finger Print",
        :page_ref => nil,
        :page_ref_type => "page_ref Type"
      )
    ])
  end

  it "renders a list of pillars" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Profile".to_s, :count => 2
    assert_select "tr>td", :text => "Finger Print".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "page_ref Type".to_s, :count => 2
  end
end
