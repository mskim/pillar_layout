require 'rails_helper'

RSpec.describe "spread_ad_boxes/index", type: :view do
  before(:each) do
    assign(:spread_ad_boxes, [
      SpreadAdBox.create!(
        :ad_type => "Ad Type",
        :advertiser => "Advertiser",
        :row => 2,
        :width => 3.5,
        :height => 4.5,
        :spread => nil
      ),
      SpreadAdBox.create!(
        :ad_type => "Ad Type",
        :advertiser => "Advertiser",
        :row => 2,
        :width => 3.5,
        :height => 4.5,
        :spread => nil
      )
    ])
  end

  it "renders a list of spread_ad_boxes" do
    render
    assert_select "tr>td", :text => "Ad Type".to_s, :count => 2
    assert_select "tr>td", :text => "Advertiser".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
