require 'rails_helper'

RSpec.describe "stories/show", type: :view do
  before(:each) do
    @story = assign(:story, Story.create!(
      :user => nil,
      :working_article => nil,
      :reporter => "Reporter",
      :group => "Group",
      :title => "Title",
      :subtitle => "Subtitle",
      :body => "Body",
      :quote => "Quote",
      :status => "Status",
      :char_count => 2,
      :published => false,
      :path => "Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Reporter/)
    expect(rendered).to match(/Group/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/Body/)
    expect(rendered).to match(/Quote/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Path/)
  end
end
