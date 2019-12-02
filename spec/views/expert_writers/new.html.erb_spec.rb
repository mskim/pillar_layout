require 'rails_helper'

RSpec.describe "expert_writers/new", type: :view do
  before(:each) do
    assign(:expert_writer, ExpertWriter.new(
      :name => "MyString",
      :work => "MyString",
      :position => "MyString",
      :email => "MyString",
      :category_code => "MyString",
      :expert_image => "MyString",
      :expert_jpg_image => "MyString"
    ))
  end

  it "renders new expert_writer form" do
    render

    assert_select "form[action=?][method=?]", expert_writers_path, "post" do

      assert_select "input[name=?]", "expert_writer[name]"

      assert_select "input[name=?]", "expert_writer[work]"

      assert_select "input[name=?]", "expert_writer[position]"

      assert_select "input[name=?]", "expert_writer[email]"

      assert_select "input[name=?]", "expert_writer[category_code]"

      assert_select "input[name=?]", "expert_writer[expert_image]"

      assert_select "input[name=?]", "expert_writer[expert_jpg_image]"
    end
  end
end
