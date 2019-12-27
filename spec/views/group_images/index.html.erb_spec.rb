require 'rails_helper'

RSpec.describe "group_images/index", type: :view do
  before(:each) do
    assign(:group_images, [
      GroupImage.create!(
        :caption_title => "Caption Title",
        :caption_description => "MyText",
        :source => "Source",
        :position => 2,
        :direction => "Direction"
      ),
      GroupImage.create!(
        :caption_title => "Caption Title",
        :caption_description => "MyText",
        :source => "Source",
        :position => 2,
        :direction => "Direction"
      )
    ])
  end

  it "renders a list of group_images" do
    render
    assert_select "tr>td", :text => "Caption Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Direction".to_s, :count => 2
  end
end
