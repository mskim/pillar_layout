require 'rails_helper'

RSpec.describe "member_images/new", type: :view do
  before(:each) do
    assign(:member_image, MemberImage.new(
      :title => "MyString",
      :caption => "MyString",
      :source => "MyString",
      :order => 1,
      :group_image => nil
    ))
  end

  it "renders new member_image form" do
    render

    assert_select "form[action=?][method=?]", member_images_path, "post" do

      assert_select "input[name=?]", "member_image[title]"

      assert_select "input[name=?]", "member_image[caption]"

      assert_select "input[name=?]", "member_image[source]"

      assert_select "input[name=?]", "member_image[order]"

      assert_select "input[name=?]", "member_image[group_image_id]"
    end
  end
end
