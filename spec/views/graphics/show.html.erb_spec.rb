require 'rails_helper'

RSpec.describe "graphics/show", type: :view do
  before(:each) do
    @graphic = assign(:graphic, Graphic.create!(
      :grid_x => 2,
      :grid_y => 3,
      :column => 4,
      :row => 5,
      :extra_height_in_lines => 6,
      :graphic => "Graphic",
      :caption => "Caption",
      :source => "Source",
      :position => "Position",
      :page_number => 7,
      :story_number => 8,
      :working_article => nil,
      :issue_id => 9
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/Graphic/)
    expect(rendered).to match(/Caption/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/Position/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(//)
    expect(rendered).to match(/9/)
  end
end
