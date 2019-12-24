require 'rails_helper'

RSpec.describe "members/new", type: :view do
  before(:each) do
    assign(:member, Member.new(
      :caption_title => "MyString",
      :caption_description => "MyText",
      :source => "MyString",
      :order => 1
    ))
  end

  it "renders new member form" do
    render

    assert_select "form[action=?][method=?]", members_path, "post" do

      assert_select "input[name=?]", "member[caption_title]"

      assert_select "textarea[name=?]", "member[caption_description]"

      assert_select "input[name=?]", "member[source]"

      assert_select "input[name=?]", "member[order]"
    end
  end
end
