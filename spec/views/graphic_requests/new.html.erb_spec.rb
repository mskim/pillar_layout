require 'rails_helper'

RSpec.describe "graphic_requests/new", type: :view do
  before(:each) do
    assign(:graphic_request, GraphicRequest.new(
      :user => nil,
      :designer => "MyString",
      :request => "MyText",
      :data => "MyText",
      :status => 1
    ))
  end

  it "renders new graphic_request form" do
    render

    assert_select "form[action=?][method=?]", graphic_requests_path, "post" do

      assert_select "input[name=?]", "graphic_request[user_id]"

      assert_select "input[name=?]", "graphic_request[designer]"

      assert_select "textarea[name=?]", "graphic_request[request]"

      assert_select "textarea[name=?]", "graphic_request[data]"

      assert_select "input[name=?]", "graphic_request[status]"
    end
  end
end
