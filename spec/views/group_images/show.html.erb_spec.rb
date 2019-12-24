require 'rails_helper'

RSpec.describe "group_images/show", type: :view do
  before(:each) do
    @group_image = assign(:group_image, GroupImage.create!(
      :caption_title => "Caption Title",
      :caption_description => "MyText",
      :source => "Source",
      :position => 2,
      :direction => "Direction"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Caption Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Direction/)
  end
end
