require 'rails_helper'

RSpec.describe "member_images/show", type: :view do
  before(:each) do
    @member_image = assign(:member_image, MemberImage.create!(
      :title => "Title",
      :caption => "Caption",
      :source => "Source",
      :order => 2,
      :group_image => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Caption/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
