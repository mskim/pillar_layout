require 'rails_helper'

RSpec.describe "member_images/edit", type: :view do
  before(:each) do
    @member_image = assign(:member_image, MemberImage.create!(
      :title => "MyString",
      :caption => "MyString",
      :source => "MyString",
      :order => 1,
      :group_image => nil
    ))
  end

  it "renders the edit member_image form" do
    render

    assert_select "form[action=?][method=?]", member_image_path(@member_image), "post" do

      assert_select "input[name=?]", "member_image[title]"

      assert_select "input[name=?]", "member_image[caption]"

      assert_select "input[name=?]", "member_image[source]"

      assert_select "input[name=?]", "member_image[order]"

      assert_select "input[name=?]", "member_image[group_image_id]"
    end
  end
end
