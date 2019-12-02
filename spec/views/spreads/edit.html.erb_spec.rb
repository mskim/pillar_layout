require 'rails_helper'

RSpec.describe "spreads/edit", type: :view do
  before(:each) do
    @spread = assign(:spread, Spread.create!(
      :issue => nil,
      :left_page_id => 1,
      :right_page_id => 1,
      :ad_box_id => 1,
      :color_page => false,
      :width => 1.5,
      :height => 1.5,
      :left_margin => 1.5,
      :top_margin => 1.5,
      :right_margin => 1.5,
      :bottom_margin => 1.5,
      :page_gutter => 1.5
    ))
  end

  it "renders the edit spread form" do
    render

    assert_select "form[action=?][method=?]", spread_path(@spread), "post" do

      assert_select "input[name=?]", "spread[issue_id]"

      assert_select "input[name=?]", "spread[left_page_id]"

      assert_select "input[name=?]", "spread[right_page_id]"

      assert_select "input[name=?]", "spread[ad_box_id]"

      assert_select "input[name=?]", "spread[color_page]"

      assert_select "input[name=?]", "spread[width]"

      assert_select "input[name=?]", "spread[height]"

      assert_select "input[name=?]", "spread[left_margin]"

      assert_select "input[name=?]", "spread[top_margin]"

      assert_select "input[name=?]", "spread[right_margin]"

      assert_select "input[name=?]", "spread[bottom_margin]"

      assert_select "input[name=?]", "spread[page_gutter]"
    end
  end
end
