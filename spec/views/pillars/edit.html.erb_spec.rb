require 'rails_helper'

RSpec.describe "pillars/edit", type: :view do
  before(:each) do
    @pillar = assign(:pillar, Pillar.create!(
      :grid_x => 1,
      :grid_y => 1,
      :column => 1,
      :row => 1,
      :order => 1,
      :box_count => 1,
      :layout_with_pillar_path => "MyText",
      :layout => "MyText",
      :profile => "MyString",
      :finger_print => "MyString",
      :region => nil,
      :region_type => "MyString"
    ))
  end

  it "renders the edit pillar form" do
    render

    assert_select "form[action=?][method=?]", pillar_path(@pillar), "post" do

      assert_select "input[name=?]", "pillar[grid_x]"

      assert_select "input[name=?]", "pillar[grid_y]"

      assert_select "input[name=?]", "pillar[column]"

      assert_select "input[name=?]", "pillar[row]"

      assert_select "input[name=?]", "pillar[order]"

      assert_select "input[name=?]", "pillar[box_count]"

      assert_select "textarea[name=?]", "pillar[layout_with_pillar_path]"

      assert_select "textarea[name=?]", "pillar[layout]"

      assert_select "input[name=?]", "pillar[profile]"

      assert_select "input[name=?]", "pillar[finger_print]"

      assert_select "input[name=?]", "pillar[region_id]"

      assert_select "input[name=?]", "pillar[region_type]"
    end
  end
end
