require 'rails_helper'

RSpec.describe "group_images/index", type: :view do
  before(:each) do
    assign(:group_images, [
      GroupImage.create!(
        :title => "Title",
        :caption => "Caption",
        :source => "Source",
        :direction => "Direction",
        :position => 2,
        :working_article => nil
      ),
      GroupImage.create!(
        :title => "Title",
        :caption => "Caption",
        :source => "Source",
        :direction => "Direction",
        :position => 2,
        :working_article => nil
      )
    ])
  end

  it "renders a list of group_images" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Caption".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Direction".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
