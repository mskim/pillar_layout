require 'rails_helper'

RSpec.describe "graphics/index", type: :view do
  before(:each) do
    assign(:graphics, [
      Graphic.create!(
        :grid_x => 2,
        :grid_y => 3,
        :column => 4,
        :row => 5,
        :extra_height_in_lines => 6,
        :graphic => "Graphic",
        :caption => "Caption",
        :source => "Source",
        :position => "Position",
        :page_number => 7,
        :story_number => 8,
        :working_article => nil,
        :issue_id => 9
      ),
      Graphic.create!(
        :grid_x => 2,
        :grid_y => 3,
        :column => 4,
        :row => 5,
        :extra_height_in_lines => 6,
        :graphic => "Graphic",
        :caption => "Caption",
        :source => "Source",
        :position => "Position",
        :page_number => 7,
        :story_number => 8,
        :working_article => nil,
        :issue_id => 9
      )
    ])
  end

  it "renders a list of graphics" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Graphic".to_s, :count => 2
    assert_select "tr>td", :text => "Caption".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
  end
end
