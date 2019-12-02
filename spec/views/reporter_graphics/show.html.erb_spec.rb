require 'rails_helper'

RSpec.describe "reporter_graphics/show", type: :view do
  before(:each) do
    @reporter_graphic = assign(:reporter_graphic, ReporterGraphic.create!(
      :user => nil,
      :title => "Title",
      :caption => "Caption",
      :source => "Source",
      :wire_pictures => "Wire Pictures",
      :section_name => "Section Name",
      :used_in_layout => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Caption/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/Wire Pictures/)
    expect(rendered).to match(/Section Name/)
    expect(rendered).to match(/false/)
  end
end
