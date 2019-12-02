require 'rails_helper'

RSpec.describe "graphic_requests/index", type: :view do
  before(:each) do
    assign(:graphic_requests, [
      GraphicRequest.create!(
        :user => nil,
        :designer => "Designer",
        :request => "MyText",
        :data => "MyText",
        :status => 2
      ),
      GraphicRequest.create!(
        :user => nil,
        :designer => "Designer",
        :request => "MyText",
        :data => "MyText",
        :status => 2
      )
    ])
  end

  it "renders a list of graphic_requests" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Designer".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
