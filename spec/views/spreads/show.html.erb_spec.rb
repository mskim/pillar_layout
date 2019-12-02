require 'rails_helper'

RSpec.describe "spreads/show", type: :view do
  before(:each) do
    @spread = assign(:spread, Spread.create!(
      :issue => nil,
      :left_page_id => 2,
      :right_page_id => 3,
      :ad_box_id => 4,
      :color_page => false,
      :width => 5.5,
      :height => 6.5,
      :left_margin => 7.5,
      :top_margin => 8.5,
      :right_margin => 9.5,
      :bottom_margin => 10.5,
      :page_gutter => 11.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7.5/)
    expect(rendered).to match(/8.5/)
    expect(rendered).to match(/9.5/)
    expect(rendered).to match(/10.5/)
    expect(rendered).to match(/11.5/)
  end
end
