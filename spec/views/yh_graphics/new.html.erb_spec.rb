require 'rails_helper'

RSpec.describe "yh_graphics/new", type: :view do
  before(:each) do
    assign(:yh_graphic, YhGraphic.new(
      :action => "MyString",
      :service_type => "MyString",
      :content_id => "MyString",
      :urgency => "MyString",
      :category => "MyString",
      :class_code => "MyString",
      :attriubute_code => "MyString",
      :source => "MyString",
      :credit => "MyString",
      :region => "MyString",
      :title => "MyString",
      :comment => "MyString",
      :body => "MyString",
      :picture => "MyString",
      :taken_by => "MyString"
    ))
  end

  it "renders new yh_graphic form" do
    render

    assert_select "form[action=?][method=?]", yh_graphics_path, "post" do

      assert_select "input[name=?]", "yh_graphic[action]"

      assert_select "input[name=?]", "yh_graphic[service_type]"

      assert_select "input[name=?]", "yh_graphic[content_id]"

      assert_select "input[name=?]", "yh_graphic[urgency]"

      assert_select "input[name=?]", "yh_graphic[category]"

      assert_select "input[name=?]", "yh_graphic[class_code]"

      assert_select "input[name=?]", "yh_graphic[attriubute_code]"

      assert_select "input[name=?]", "yh_graphic[source]"

      assert_select "input[name=?]", "yh_graphic[credit]"

      assert_select "input[name=?]", "yh_graphic[region]"

      assert_select "input[name=?]", "yh_graphic[title]"

      assert_select "input[name=?]", "yh_graphic[comment]"

      assert_select "input[name=?]", "yh_graphic[body]"

      assert_select "input[name=?]", "yh_graphic[picture]"

      assert_select "input[name=?]", "yh_graphic[taken_by]"
    end
  end
end
