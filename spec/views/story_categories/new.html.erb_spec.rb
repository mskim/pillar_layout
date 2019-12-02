require 'rails_helper'

RSpec.describe "story_categories/new", type: :view do
  before(:each) do
    assign(:story_category, StoryCategory.new(
      :name => "MyString",
      :code => "MyString"
    ))
  end

  it "renders new story_category form" do
    render

    assert_select "form[action=?][method=?]", story_categories_path, "post" do

      assert_select "input[name=?]", "story_category[name]"

      assert_select "input[name=?]", "story_category[code]"
    end
  end
end
