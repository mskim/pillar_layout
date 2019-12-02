require 'rails_helper'

RSpec.describe "story_categories/edit", type: :view do
  before(:each) do
    @story_category = assign(:story_category, StoryCategory.create!(
      :name => "MyString",
      :code => "MyString"
    ))
  end

  it "renders the edit story_category form" do
    render

    assert_select "form[action=?][method=?]", story_category_path(@story_category), "post" do

      assert_select "input[name=?]", "story_category[name]"

      assert_select "input[name=?]", "story_category[code]"
    end
  end
end
