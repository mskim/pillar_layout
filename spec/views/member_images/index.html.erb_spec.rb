require 'rails_helper'

RSpec.describe "member_images/index", type: :view do
  before(:each) do
    assign(:member_images, [
      MemberImage.create!(
        :title => "Title",
        :caption => "Caption",
        :source => "Source",
        :order => 2,
        :group_image => nil
      ),
      MemberImage.create!(
        :title => "Title",
        :caption => "Caption",
        :source => "Source",
        :order => 2,
        :group_image => nil
      )
    ])
  end

  it "renders a list of member_images" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Caption".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
