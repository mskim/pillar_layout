require 'rails_helper'

RSpec.describe "ad_plans/index", type: :view do
  before(:each) do
    assign(:ad_plans, [
      AdPlan.create!(
        :page_number => 2,
        :ad_type => "Ad Type",
        :advertiser => "Advertiser",
        :color_page => false,
        :comment => "Comment"
      ),
      AdPlan.create!(
        :page_number => 2,
        :ad_type => "Ad Type",
        :advertiser => "Advertiser",
        :color_page => false,
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of ad_plans" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Ad Type".to_s, :count => 2
    assert_select "tr>td", :text => "Advertiser".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
