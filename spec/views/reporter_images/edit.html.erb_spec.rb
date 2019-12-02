require 'rails_helper'

RSpec.describe "reporter_images/edit", type: :view do
  before(:each) do
    @reporter_image = assign(:reporter_image, ReporterImage.create!(
      :user => nil,
      :title => "MyString",
      :caption => "MyString",
      :source => "MyString",
      :reporter_image => "MyString"
    ))
  end

  it "renders the edit reporter_image form" do
    render

    assert_select "form[action=?][method=?]", reporter_image_path(@reporter_image), "post" do

      assert_select "input[name=?]", "reporter_image[user_id]"

      assert_select "input[name=?]", "reporter_image[title]"

      assert_select "input[name=?]", "reporter_image[caption]"

      assert_select "input[name=?]", "reporter_image[source]"

      assert_select "input[name=?]", "reporter_image[reporter_image]"
    end
  end
end
