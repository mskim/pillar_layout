require 'rails_helper'

RSpec.describe "graphic_requests/edit", type: :view do
  before(:each) do
    @graphic_request = assign(:graphic_request, GraphicRequest.create!(
      :user => nil,
      :designer => "MyString",
      :request => "MyText",
      :data => "MyText",
      :status => 1
    ))
  end

  it "renders the edit graphic_request form" do
    render

    assert_select "form[action=?][method=?]", graphic_request_path(@graphic_request), "post" do

      assert_select "input[name=?]", "graphic_request[user_id]"

      assert_select "input[name=?]", "graphic_request[designer]"

      assert_select "textarea[name=?]", "graphic_request[request]"

      assert_select "textarea[name=?]", "graphic_request[data]"

      assert_select "input[name=?]", "graphic_request[status]"
    end
  end
end
