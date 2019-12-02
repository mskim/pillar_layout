require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
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

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

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
