require 'rails_helper'

RSpec.describe "combo_ads/show", type: :view do
  before(:each) do
    @combo_ad = assign(:combo_ad, ComboAd.create!(
      :base_ad => "Base Ad",
      :column => 2,
      :row => 3,
      :layout => "MyText",
      :profile => "Profile"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Base Ad/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Profile/)
  end
end
