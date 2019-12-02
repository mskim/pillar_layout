require 'rails_helper'

RSpec.describe "story_subcategories/show", type: :view do
  before(:each) do
    @story_subcategory = assign(:story_subcategory, StorySubcategory.create!(
      :name => "Name",
      :code => "Code",
      :story_category => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(//)
  end
end
