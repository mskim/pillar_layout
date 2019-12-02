require 'rails_helper'

RSpec.describe "page_layouts/show", type: :view do
  before(:each) do
    @page_layout = assign(:page_layout, PageLayout.create!(
      :doc_width => 2.5,
      :doc_height => 3.5,
      :ad_type => "Ad Type",
      :page_type => "Page Type",
      :column => 4,
      :row => 5,
      :pillar_count => 6,
      :grid_width => 7.5,
      :grid_height => 8.5,
      :gutter => 9.5,
      :margin => 10.5,
      :layout => "MyText",
      :layout_with_pillar_path => "MyText",
      :like => 11
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/Ad Type/)
    expect(rendered).to match(/Page Type/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7.5/)
    expect(rendered).to match(/8.5/)
    expect(rendered).to match(/9.5/)
    expect(rendered).to match(/10.5/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/11/)
  end
end
