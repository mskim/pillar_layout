require 'rails_helper'

RSpec.describe "graphics/edit", type: :view do
  before(:each) do
    @graphic = assign(:graphic, Graphic.create!(
      :grid_x => 1,
      :grid_y => 1,
      :column => 1,
      :row => 1,
      :extra_height_in_lines => 1,
      :graphic => "MyString",
      :caption => "MyString",
      :source => "MyString",
      :position => "MyString",
      :page_number => 1,
      :story_number => 1,
      :working_article => nil,
      :issue_id => 1
    ))
  end

  it "renders the edit graphic form" do
    render

    assert_select "form[action=?][method=?]", graphic_path(@graphic), "post" do

      assert_select "input[name=?]", "graphic[grid_x]"

      assert_select "input[name=?]", "graphic[grid_y]"

      assert_select "input[name=?]", "graphic[column]"

      assert_select "input[name=?]", "graphic[row]"

      assert_select "input[name=?]", "graphic[extra_height_in_lines]"

      assert_select "input[name=?]", "graphic[graphic]"

      assert_select "input[name=?]", "graphic[caption]"

      assert_select "input[name=?]", "graphic[source]"

      assert_select "input[name=?]", "graphic[position]"

      assert_select "input[name=?]", "graphic[page_number]"

      assert_select "input[name=?]", "graphic[story_number]"

      assert_select "input[name=?]", "graphic[working_article_id]"

      assert_select "input[name=?]", "graphic[issue_id]"
    end
  end
end
