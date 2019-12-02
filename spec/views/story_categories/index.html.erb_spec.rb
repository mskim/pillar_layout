require 'rails_helper'

RSpec.describe "story_categories/index", type: :view do
  before(:each) do
    assign(:story_categories, [
      StoryCategory.create!(
        :name => "Name",
        :code => "Code"
      ),
      StoryCategory.create!(
        :name => "Name",
        :code => "Code"
      )
    ])
  end

  it "renders a list of story_categories" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Code".to_s, :count => 2
  end
end
