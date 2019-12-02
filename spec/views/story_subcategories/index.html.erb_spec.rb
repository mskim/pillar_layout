require 'rails_helper'

RSpec.describe "story_subcategories/index", type: :view do
  before(:each) do
    assign(:story_subcategories, [
      StorySubcategory.create!(
        :name => "Name",
        :code => "Code",
        :story_category => nil
      ),
      StorySubcategory.create!(
        :name => "Name",
        :code => "Code",
        :story_category => nil
      )
    ])
  end

  it "renders a list of story_subcategories" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
