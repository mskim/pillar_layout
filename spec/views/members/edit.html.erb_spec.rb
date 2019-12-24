require 'rails_helper'

RSpec.describe "members/edit", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      :caption_title => "MyString",
      :caption_description => "MyText",
      :source => "MyString",
      :order => 1
    ))
  end

  it "renders the edit member form" do
    render

    assert_select "form[action=?][method=?]", member_path(@member), "post" do

      assert_select "input[name=?]", "member[caption_title]"

      assert_select "textarea[name=?]", "member[caption_description]"

      assert_select "input[name=?]", "member[source]"

      assert_select "input[name=?]", "member[order]"
    end
  end
end
