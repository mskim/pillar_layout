require 'rails_helper'

RSpec.describe "combo_ads/index", type: :view do
  before(:each) do
    assign(:combo_ads, [
      ComboAd.create!(
        :base_ad => "Base Ad",
        :column => 2,
        :row => 3,
        :layout => "MyText",
        :profile => "Profile"
      ),
      ComboAd.create!(
        :base_ad => "Base Ad",
        :column => 2,
        :row => 3,
        :layout => "MyText",
        :profile => "Profile"
      )
    ])
  end

  it "renders a list of combo_ads" do
    render
    assert_select "tr>td", :text => "Base Ad".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Profile".to_s, :count => 2
  end
end
