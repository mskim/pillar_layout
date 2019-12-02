require 'rails_helper'

RSpec.describe "reporter_images/show", type: :view do
  before(:each) do
    @reporter_image = assign(:reporter_image, ReporterImage.create!(
      :user => nil,
      :title => "Title",
      :caption => "Caption",
      :source => "Source",
      :reporter_image => "Reporter Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Caption/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/Reporter Image/)
  end
end
