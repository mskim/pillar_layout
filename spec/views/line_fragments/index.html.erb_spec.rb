require 'rails_helper'

RSpec.describe "line_fragments/index", type: :view do
  before(:each) do
    assign(:line_fragments, [
      LineFragment.create!(
        :working_article => nil,
        :paragraph => nil,
        :order => 2,
        :column => 3,
        :line_type => "Line Type",
        :x => 4.5,
        :y => 5.5,
        :width => 6.5,
        :height => 7.5,
        :tokens => "MyText",
        :text_area_x => 8.5,
        :text_area_width => 9.5
      ),
      LineFragment.create!(
        :working_article => nil,
        :paragraph => nil,
        :order => 2,
        :column => 3,
        :line_type => "Line Type",
        :x => 4.5,
        :y => 5.5,
        :width => 6.5,
        :height => 7.5,
        :tokens => "MyText",
        :text_area_x => 8.5,
        :text_area_width => 9.5
      )
    ])
  end

  it "renders a list of line_fragments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Line Type".to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 8.5.to_s, :count => 2
    assert_select "tr>td", :text => 9.5.to_s, :count => 2
  end
end
