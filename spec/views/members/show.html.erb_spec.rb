require 'rails_helper'

RSpec.describe "members/show", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      :caption_title => "Caption Title",
      :caption_description => "MyText",
      :source => "Source",
      :order => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Caption Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/2/)
  end
end
