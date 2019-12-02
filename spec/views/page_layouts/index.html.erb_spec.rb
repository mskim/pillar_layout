require 'rails_helper'

RSpec.describe "page_layouts/index", type: :view do
  before(:each) do
    assign(:page_layouts, [
      PageLayout.create!(
        :doc_width => 2.5,
        :doc_height => 3.5,
        :ad_type => "Ad Type",
        :page_type => "Page Type",
        :column => 4,
        :row => 5,
        :pillar_count => 6,
        :grid_width => 7.5,
        :grid_height => 8.5,
        :gutter => 9.5,
        :margin => 10.5,
        :layout => "MyText",
        :layout_with_pillar_path => "MyText",
        :like => 11
      ),
      PageLayout.create!(
        :doc_width => 2.5,
        :doc_height => 3.5,
        :ad_type => "Ad Type",
        :page_type => "Page Type",
        :column => 4,
        :row => 5,
        :pillar_count => 6,
        :grid_width => 7.5,
        :grid_height => 8.5,
        :gutter => 9.5,
        :margin => 10.5,
        :layout => "MyText",
        :layout_with_pillar_path => "MyText",
        :like => 11
      )
    ])
  end

  it "renders a list of page_layouts" do
    render
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "Ad Type".to_s, :count => 2
    assert_select "tr>td", :text => "Page Type".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
    assert_select "tr>td", :text => 8.5.to_s, :count => 2
    assert_select "tr>td", :text => 9.5.to_s, :count => 2
    assert_select "tr>td", :text => 10.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
  end
end
