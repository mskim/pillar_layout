require 'rails_helper'

RSpec.describe "spread_ad_boxes/new", type: :view do
  before(:each) do
    assign(:spread_ad_box, SpreadAdBox.new(
      :ad_type => "MyString",
      :advertiser => "MyString",
      :row => 1,
      :width => 1.5,
      :height => 1.5,
      :spread => nil
    ))
  end

  it "renders new spread_ad_box form" do
    render

    assert_select "form[action=?][method=?]", spread_ad_boxes_path, "post" do

      assert_select "input[name=?]", "spread_ad_box[ad_type]"

      assert_select "input[name=?]", "spread_ad_box[advertiser]"

      assert_select "input[name=?]", "spread_ad_box[row]"

      assert_select "input[name=?]", "spread_ad_box[width]"

      assert_select "input[name=?]", "spread_ad_box[height]"

      assert_select "input[name=?]", "spread_ad_box[spread_id]"
    end
  end
end
