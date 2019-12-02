require 'rails_helper'

RSpec.describe "graphic_requests/show", type: :view do
  before(:each) do
    @graphic_request = assign(:graphic_request, GraphicRequest.create!(
      :user => nil,
      :designer => "Designer",
      :request => "MyText",
      :data => "MyText",
      :status => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Designer/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end
