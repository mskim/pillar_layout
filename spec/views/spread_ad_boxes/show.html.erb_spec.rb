require 'rails_helper'

RSpec.describe "spread_ad_boxes/show", type: :view do
  before(:each) do
    @spread_ad_box = assign(:spread_ad_box, SpreadAdBox.create!(
      :ad_type => "Ad Type",
      :advertiser => "Advertiser",
      :row => 2,
      :width => 3.5,
      :height => 4.5,
      :spread => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Ad Type/)
    expect(rendered).to match(/Advertiser/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(//)
  end
end
