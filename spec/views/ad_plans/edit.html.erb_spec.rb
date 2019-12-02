require 'rails_helper'

RSpec.describe "ad_plans/edit", type: :view do
  before(:each) do
    @ad_plan = assign(:ad_plan, AdPlan.create!(
      :page_number => 1,
      :ad_type => "MyString",
      :advertiser => "MyString",
      :color_page => false,
      :comment => "MyString"
    ))
  end

  it "renders the edit ad_plan form" do
    render

    assert_select "form[action=?][method=?]", ad_plan_path(@ad_plan), "post" do

      assert_select "input[name=?]", "ad_plan[page_number]"

      assert_select "input[name=?]", "ad_plan[ad_type]"

      assert_select "input[name=?]", "ad_plan[advertiser]"

      assert_select "input[name=?]", "ad_plan[color_page]"

      assert_select "input[name=?]", "ad_plan[comment]"
    end
  end
end
