require 'rails_helper'

RSpec.describe "reporter_images/index", type: :view do
  before(:each) do
    assign(:reporter_images, [
      ReporterImage.create!(
        :user => nil,
        :title => "Title",
        :caption => "Caption",
        :source => "Source",
        :reporter_image => "Reporter Image"
      ),
      ReporterImage.create!(
        :user => nil,
        :title => "Title",
        :caption => "Caption",
        :source => "Source",
        :reporter_image => "Reporter Image"
      )
    ])
  end

  it "renders a list of reporter_images" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Caption".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Reporter Image".to_s, :count => 2
  end
end
