require 'rails_helper'

RSpec.describe "page_layouts/edit", type: :view do
  before(:each) do
    @page_layout = assign(:page_layout, PageLayout.create!(
      :doc_width => 1.5,
      :doc_height => 1.5,
      :ad_type => "MyString",
      :page_type => "MyString",
      :column => 1,
      :row => 1,
      :pillar_count => 1,
      :grid_width => 1.5,
      :grid_height => 1.5,
      :gutter => 1.5,
      :margin => 1.5,
      :layout => "MyText",
      :layout_with_pillar_path => "MyText",
      :like => 1
    ))
  end

  it "renders the edit page_layout form" do
    render

    assert_select "form[action=?][method=?]", page_layout_path(@page_layout), "post" do

      assert_select "input[name=?]", "page_layout[doc_width]"

      assert_select "input[name=?]", "page_layout[doc_height]"

      assert_select "input[name=?]", "page_layout[ad_type]"

      assert_select "input[name=?]", "page_layout[page_type]"

      assert_select "input[name=?]", "page_layout[column]"

      assert_select "input[name=?]", "page_layout[row]"

      assert_select "input[name=?]", "page_layout[pillar_count]"

      assert_select "input[name=?]", "page_layout[grid_width]"

      assert_select "input[name=?]", "page_layout[grid_height]"

      assert_select "input[name=?]", "page_layout[gutter]"

      assert_select "input[name=?]", "page_layout[margin]"

      assert_select "textarea[name=?]", "page_layout[layout]"

      assert_select "textarea[name=?]", "page_layout[layout_with_pillar_path]"

      assert_select "input[name=?]", "page_layout[like]"
    end
  end
end
