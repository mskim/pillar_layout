require 'rails_helper'

RSpec.describe "group_images/edit", type: :view do
  before(:each) do
    @group_image = assign(:group_image, GroupImage.create!(
      :caption_title => "MyString",
      :caption_description => "MyText",
      :source => "MyString",
      :position => 1,
      :direction => "MyString"
    ))
  end

  it "renders the edit group_image form" do
    render

    assert_select "form[action=?][method=?]", group_image_path(@group_image), "post" do

      assert_select "input[name=?]", "group_image[caption_title]"

      assert_select "textarea[name=?]", "group_image[caption_description]"

      assert_select "input[name=?]", "group_image[source]"

      assert_select "input[name=?]", "group_image[position]"

      assert_select "input[name=?]", "group_image[direction]"
    end
  end
end
