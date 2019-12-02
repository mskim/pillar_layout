require 'rails_helper'

RSpec.describe "stories/edit", type: :view do
  before(:each) do
    @story = assign(:story, Story.create!(
      :user => nil,
      :working_article => nil,
      :reporter => "MyString",
      :group => "MyString",
      :title => "MyString",
      :subtitle => "MyString",
      :body => "MyString",
      :quote => "MyString",
      :status => "MyString",
      :char_count => 1,
      :published => false,
      :path => "MyString"
    ))
  end

  it "renders the edit story form" do
    render

    assert_select "form[action=?][method=?]", story_path(@story), "post" do

      assert_select "input[name=?]", "story[user_id]"

      assert_select "input[name=?]", "story[working_article_id]"

      assert_select "input[name=?]", "story[reporter]"

      assert_select "input[name=?]", "story[group]"

      assert_select "input[name=?]", "story[title]"

      assert_select "input[name=?]", "story[subtitle]"

      assert_select "input[name=?]", "story[body]"

      assert_select "input[name=?]", "story[quote]"

      assert_select "input[name=?]", "story[status]"

      assert_select "input[name=?]", "story[char_count]"

      assert_select "input[name=?]", "story[published]"

      assert_select "input[name=?]", "story[path]"
    end
  end
end
