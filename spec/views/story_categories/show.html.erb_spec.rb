require 'rails_helper'

RSpec.describe "story_categories/show", type: :view do
  before(:each) do
    @story_category = assign(:story_category, StoryCategory.create!(
      :name => "Name",
      :code => "Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Code/)
  end
end
