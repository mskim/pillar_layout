require 'rails_helper'

RSpec.describe "body_lines/new", type: :view do
  before(:each) do
    assign(:body_line, BodyLine.new(
      :order => 1,
      :x => 1.5,
      :y => "",
      :width => 1.5,
      :height => 1.5,
      :coulumn => 1,
      :line_number => 1,
      :tokens => "MyText",
      :overflow => "",
      :working_aticle => nil
    ))
  end

  it "renders new body_line form" do
    render

    assert_select "form[action=?][method=?]", body_lines_path, "post" do

      assert_select "input[name=?]", "body_line[order]"

      assert_select "input[name=?]", "body_line[x]"

      assert_select "input[name=?]", "body_line[y]"

      assert_select "input[name=?]", "body_line[width]"

      assert_select "input[name=?]", "body_line[height]"

      assert_select "input[name=?]", "body_line[coulumn]"

      assert_select "input[name=?]", "body_line[line_number]"

      assert_select "textarea[name=?]", "body_line[tokens]"

      assert_select "input[name=?]", "body_line[overflow]"

      assert_select "input[name=?]", "body_line[working_aticle_id]"
    end
  end
end