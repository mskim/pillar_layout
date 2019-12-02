require 'rails_helper'

RSpec.describe "spreads/index", type: :view do
  before(:each) do
    assign(:spreads, [
      Spread.create!(
        :issue => nil,
        :left_page_id => 2,
        :right_page_id => 3,
        :ad_box_id => 4,
        :color_page => false,
        :width => 5.5,
        :height => 6.5,
        :left_margin => 7.5,
        :top_margin => 8.5,
        :right_margin => 9.5,
        :bottom_margin => 10.5,
        :page_gutter => 11.5
      ),
      Spread.create!(
        :issue => nil,
        :left_page_id => 2,
        :right_page_id => 3,
        :ad_box_id => 4,
        :color_page => false,
        :width => 5.5,
        :height => 6.5,
        :left_margin => 7.5,
        :top_margin => 8.5,
        :right_margin => 9.5,
        :bottom_margin => 10.5,
        :page_gutter => 11.5
      )
    ])
  end

  it "renders a list of spreads" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
    assert_select "tr>td", :text => 8.5.to_s, :count => 2
    assert_select "tr>td", :text => 9.5.to_s, :count => 2
    assert_select "tr>td", :text => 10.5.to_s, :count => 2
    assert_select "tr>td", :text => 11.5.to_s, :count => 2
  end
end
