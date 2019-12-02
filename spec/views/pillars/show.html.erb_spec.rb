require 'rails_helper'

RSpec.describe "pillars/show", type: :view do
  before(:each) do
    @pillar = assign(:pillar, Pillar.create!(
      :grid_x => 2,
      :grid_y => 3,
      :column => 4,
      :row => 5,
      :order => 6,
      :box_count => 7,
      :layout_with_pillar_path => "MyText",
      :layout => "MyText",
      :profile => "Profile",
      :finger_print => "Finger Print",
      :region => nil,
      :region_type => "Region Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Profile/)
    expect(rendered).to match(/Finger Print/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Region Type/)
  end
end
