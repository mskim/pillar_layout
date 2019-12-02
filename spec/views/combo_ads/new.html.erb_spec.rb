require 'rails_helper'

RSpec.describe "combo_ads/new", type: :view do
  before(:each) do
    assign(:combo_ad, ComboAd.new(
      :base_ad => "MyString",
      :column => 1,
      :row => 1,
      :layout => "MyText",
      :profile => "MyString"
    ))
  end

  it "renders new combo_ad form" do
    render

    assert_select "form[action=?][method=?]", combo_ads_path, "post" do

      assert_select "input[name=?]", "combo_ad[base_ad]"

      assert_select "input[name=?]", "combo_ad[column]"

      assert_select "input[name=?]", "combo_ad[row]"

      assert_select "textarea[name=?]", "combo_ad[layout]"

      assert_select "input[name=?]", "combo_ad[profile]"
    end
  end
end
