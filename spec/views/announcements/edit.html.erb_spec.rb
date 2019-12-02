require 'rails_helper'

RSpec.describe "announcements/edit", type: :view do
  before(:each) do
    @announcement = assign(:announcement, Announcement.create!(
      :name => "MyString",
      :kind => "MyString",
      :title => "MyString",
      :subtitle => "MyString",
      :column => 1,
      :lines => 1,
      :page => 1,
      :color => "MyString",
      :script => "MyText",
      :publication => nil
    ))
  end

  it "renders the edit announcement form" do
    render

    assert_select "form[action=?][method=?]", announcement_path(@announcement), "post" do

      assert_select "input[name=?]", "announcement[name]"

      assert_select "input[name=?]", "announcement[kind]"

      assert_select "input[name=?]", "announcement[title]"

      assert_select "input[name=?]", "announcement[subtitle]"

      assert_select "input[name=?]", "announcement[column]"

      assert_select "input[name=?]", "announcement[lines]"

      assert_select "input[name=?]", "announcement[page]"

      assert_select "input[name=?]", "announcement[color]"

      assert_select "textarea[name=?]", "announcement[script]"

      assert_select "input[name=?]", "announcement[publication_id]"
    end
  end
end
