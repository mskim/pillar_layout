require 'rails_helper'

RSpec.describe "reporter_images/new", type: :view do
  before(:each) do
    assign(:reporter_image, ReporterImage.new(
      :user => nil,
      :title => "MyString",
      :caption => "MyString",
      :source => "MyString",
      :reporter_image => "MyString"
    ))
  end

  it "renders new reporter_image form" do
    render

    assert_select "form[action=?][method=?]", reporter_images_path, "post" do

      assert_select "input[name=?]", "reporter_image[user_id]"

      assert_select "input[name=?]", "reporter_image[title]"

      assert_select "input[name=?]", "reporter_image[caption]"

      assert_select "input[name=?]", "reporter_image[source]"

      assert_select "input[name=?]", "reporter_image[reporter_image]"
    end
  end
end
