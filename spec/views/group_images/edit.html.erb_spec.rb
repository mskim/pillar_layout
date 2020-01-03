require 'rails_helper'

RSpec.describe "group_images/edit", type: :view do
  before(:each) do
    @group_image = assign(:group_image, GroupImage.create!(
      :title => "MyString",
      :caption => "MyString",
      :source => "MyString",
      :direction => "MyString",
      :position => 1,
      :working_article => nil
    ))
  end

  it "renders the edit group_image form" do
    render

    assert_select "form[action=?][method=?]", group_image_path(@group_image), "post" do

      assert_select "input[name=?]", "group_image[title]"

      assert_select "input[name=?]", "group_image[caption]"

      assert_select "input[name=?]", "group_image[source]"

      assert_select "input[name=?]", "group_image[direction]"

      assert_select "input[name=?]", "group_image[position]"

      assert_select "input[name=?]", "group_image[working_article_id]"
    end
  end
end
