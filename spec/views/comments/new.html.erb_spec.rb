require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    assign(:comment, Comment.new(
      :name => "MyString",
      :text => "MyString",
      :image => "MyString",
      :x_value => 1.5,
      :y_value => 1.5,
      :width => 1.5,
      :height => 1.5,
      :proof => nil
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "input[name=?]", "comment[name]"

      assert_select "input[name=?]", "comment[text]"

      assert_select "input[name=?]", "comment[image]"

      assert_select "input[name=?]", "comment[x_value]"

      assert_select "input[name=?]", "comment[y_value]"

      assert_select "input[name=?]", "comment[width]"

      assert_select "input[name=?]", "comment[height]"

      assert_select "input[name=?]", "comment[proof_id]"
    end
  end
end
