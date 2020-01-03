require 'rails_helper'

RSpec.describe "group_images/show", type: :view do
  before(:each) do
    @group_image = assign(:group_image, GroupImage.create!(
      :title => "Title",
      :caption => "Caption",
      :source => "Source",
      :direction => "Direction",
      :position => 2,
      :working_article => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Caption/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/Direction/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
