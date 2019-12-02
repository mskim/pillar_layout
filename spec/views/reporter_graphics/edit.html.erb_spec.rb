require 'rails_helper'

RSpec.describe "reporter_graphics/edit", type: :view do
  before(:each) do
    @reporter_graphic = assign(:reporter_graphic, ReporterGraphic.create!(
      :user => nil,
      :title => "MyString",
      :caption => "MyString",
      :source => "MyString",
      :wire_pictures => "MyString",
      :section_name => "MyString",
      :used_in_layout => false
    ))
  end

  it "renders the edit reporter_graphic form" do
    render

    assert_select "form[action=?][method=?]", reporter_graphic_path(@reporter_graphic), "post" do

      assert_select "input[name=?]", "reporter_graphic[user_id]"

      assert_select "input[name=?]", "reporter_graphic[title]"

      assert_select "input[name=?]", "reporter_graphic[caption]"

      assert_select "input[name=?]", "reporter_graphic[source]"

      assert_select "input[name=?]", "reporter_graphic[wire_pictures]"

      assert_select "input[name=?]", "reporter_graphic[section_name]"

      assert_select "input[name=?]", "reporter_graphic[used_in_layout]"
    end
  end
end
