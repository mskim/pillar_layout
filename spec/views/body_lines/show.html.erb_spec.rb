require 'rails_helper'

RSpec.describe "body_lines/show", type: :view do
  before(:each) do
    @body_line = assign(:body_line, BodyLine.create!(
      :order => 2,
      :x => 3.5,
      :y => "",
      :width => 4.5,
      :height => 5.5,
      :coulumn => 6,
      :line_number => 7,
      :tokens => "MyText",
      :overflow => "",
      :working_aticle => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(//)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
