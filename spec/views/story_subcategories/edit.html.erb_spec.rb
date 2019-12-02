require 'rails_helper'

RSpec.describe "story_subcategories/edit", type: :view do
  before(:each) do
    @story_subcategory = assign(:story_subcategory, StorySubcategory.create!(
      :name => "MyString",
      :code => "MyString",
      :story_category => nil
    ))
  end

  it "renders the edit story_subcategory form" do
    render

    assert_select "form[action=?][method=?]", story_subcategory_path(@story_subcategory), "post" do

      assert_select "input[name=?]", "story_subcategory[name]"

      assert_select "input[name=?]", "story_subcategory[code]"

      assert_select "input[name=?]", "story_subcategory[story_category_id]"
    end
  end
end
