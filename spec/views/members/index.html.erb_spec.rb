require 'rails_helper'

RSpec.describe "members/index", type: :view do
  before(:each) do
    assign(:members, [
      Member.create!(
        :caption_title => "Caption Title",
        :caption_description => "MyText",
        :source => "Source",
        :order => 2
      ),
      Member.create!(
        :caption_title => "Caption Title",
        :caption_description => "MyText",
        :source => "Source",
        :order => 2
      )
    ])
  end

  it "renders a list of members" do
    render
    assert_select "tr>td", :text => "Caption Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
