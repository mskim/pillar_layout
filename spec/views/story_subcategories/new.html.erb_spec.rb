require 'rails_helper'

RSpec.describe "story_subcategories/new", type: :view do
  before(:each) do
    assign(:story_subcategory, StorySubcategory.new(
      :name => "MyString",
      :code => "MyString",
      :story_category => nil
    ))
  end

  it "renders new story_subcategory form" do
    render

    assert_select "form[action=?][method=?]", story_subcategories_path, "post" do

      assert_select "input[name=?]", "story_subcategory[name]"

      assert_select "input[name=?]", "story_subcategory[code]"

      assert_select "input[name=?]", "story_subcategory[story_category_id]"
    end
  end
end
