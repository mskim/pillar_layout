require 'rails_helper'

RSpec.describe "combo_ads/edit", type: :view do
  before(:each) do
    @combo_ad = assign(:combo_ad, ComboAd.create!(
      :base_ad => "MyString",
      :column => 1,
      :row => 1,
      :layout => "MyText",
      :profile => "MyString"
    ))
  end

  it "renders the edit combo_ad form" do
    render

    assert_select "form[action=?][method=?]", combo_ad_path(@combo_ad), "post" do

      assert_select "input[name=?]", "combo_ad[base_ad]"

      assert_select "input[name=?]", "combo_ad[column]"

      assert_select "input[name=?]", "combo_ad[row]"

      assert_select "textarea[name=?]", "combo_ad[layout]"

      assert_select "input[name=?]", "combo_ad[profile]"
    end
  end
end
