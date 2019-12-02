require 'rails_helper'

RSpec.describe "line_fragments/show", type: :view do
  before(:each) do
    @line_fragment = assign(:line_fragment, LineFragment.create!(
      :working_article => nil,
      :paragraph => nil,
      :order => 2,
      :column => 3,
      :line_type => "Line Type",
      :x => 4.5,
      :y => 5.5,
      :width => 6.5,
      :height => 7.5,
      :tokens => "MyText",
      :text_area_x => 8.5,
      :text_area_width => 9.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Line Type/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7.5/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/8.5/)
    expect(rendered).to match(/9.5/)
  end
end
