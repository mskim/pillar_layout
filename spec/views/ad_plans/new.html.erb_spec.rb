require 'rails_helper'

RSpec.describe "ad_plans/new", type: :view do
  before(:each) do
    assign(:ad_plan, AdPlan.new(
      :page_number => 1,
      :ad_type => "MyString",
      :advertiser => "MyString",
      :color_page => false,
      :comment => "MyString"
    ))
  end

  it "renders new ad_plan form" do
    render

    assert_select "form[action=?][method=?]", ad_plans_path, "post" do

      assert_select "input[name=?]", "ad_plan[page_number]"

      assert_select "input[name=?]", "ad_plan[ad_type]"

      assert_select "input[name=?]", "ad_plan[advertiser]"

      assert_select "input[name=?]", "ad_plan[color_page]"

      assert_select "input[name=?]", "ad_plan[comment]"
    end
  end
end
