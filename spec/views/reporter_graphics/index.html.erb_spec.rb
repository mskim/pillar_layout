require 'rails_helper'

RSpec.describe "reporter_graphics/index", type: :view do
  before(:each) do
    assign(:reporter_graphics, [
      ReporterGraphic.create!(
        :user => nil,
        :title => "Title",
        :caption => "Caption",
        :source => "Source",
        :wire_pictures => "Wire Pictures",
        :section_name => "Section Name",
        :used_in_layout => false
      ),
      ReporterGraphic.create!(
        :user => nil,
        :title => "Title",
        :caption => "Caption",
        :source => "Source",
        :wire_pictures => "Wire Pictures",
        :section_name => "Section Name",
        :used_in_layout => false
      )
    ])
  end

  it "renders a list of reporter_graphics" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Caption".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Wire Pictures".to_s, :count => 2
    assert_select "tr>td", :text => "Section Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
