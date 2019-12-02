require 'rails_helper'

RSpec.describe "announcements/new", type: :view do
  before(:each) do
    assign(:announcement, Announcement.new(
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

  it "renders new announcement form" do
    render

    assert_select "form[action=?][method=?]", announcements_path, "post" do

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
