require 'rails_helper'

RSpec.describe "line_fragments/new", type: :view do
  before(:each) do
    assign(:line_fragment, LineFragment.new(
      :working_article => nil,
      :paragraph => nil,
      :order => 1,
      :column => 1,
      :line_type => "MyString",
      :x => 1.5,
      :y => 1.5,
      :width => 1.5,
      :height => 1.5,
      :tokens => "MyText",
      :text_area_x => 1.5,
      :text_area_width => 1.5
    ))
  end

  it "renders new line_fragment form" do
    render

    assert_select "form[action=?][method=?]", line_fragments_path, "post" do

      assert_select "input[name=?]", "line_fragment[working_article_id]"

      assert_select "input[name=?]", "line_fragment[paragraph_id]"

      assert_select "input[name=?]", "line_fragment[order]"

      assert_select "input[name=?]", "line_fragment[column]"

      assert_select "input[name=?]", "line_fragment[line_type]"

      assert_select "input[name=?]", "line_fragment[x]"

      assert_select "input[name=?]", "line_fragment[y]"

      assert_select "input[name=?]", "line_fragment[width]"

      assert_select "input[name=?]", "line_fragment[height]"

      assert_select "textarea[name=?]", "line_fragment[tokens]"

      assert_select "input[name=?]", "line_fragment[text_area_x]"

      assert_select "input[name=?]", "line_fragment[text_area_width]"
    end
  end
end
