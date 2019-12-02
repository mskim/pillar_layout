require 'rails_helper'

RSpec.describe "ad_plans/show", type: :view do
  before(:each) do
    @ad_plan = assign(:ad_plan, AdPlan.create!(
      :page_number => 2,
      :ad_type => "Ad Type",
      :advertiser => "Advertiser",
      :color_page => false,
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Ad Type/)
    expect(rendered).to match(/Advertiser/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Comment/)
  end
end
