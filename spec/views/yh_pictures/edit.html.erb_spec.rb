require 'rails_helper'

RSpec.describe "yh_pictures/edit", type: :view do
  before(:each) do
    @yh_picture = assign(:yh_picture, YhPicture.create!(
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
      :file_name => "MyString",
      :taken_by => "MyString"
    ))
  end

  it "renders the edit yh_picture form" do
    render

    assert_select "form[action=?][method=?]", yh_picture_path(@yh_picture), "post" do

      assert_select "input[name=?]", "yh_picture[action]"

      assert_select "input[name=?]", "yh_picture[service_type]"

      assert_select "input[name=?]", "yh_picture[content_id]"

      assert_select "input[name=?]", "yh_picture[urgency]"

      assert_select "input[name=?]", "yh_picture[category]"

      assert_select "input[name=?]", "yh_picture[class_code]"

      assert_select "input[name=?]", "yh_picture[attriubute_code]"

      assert_select "input[name=?]", "yh_picture[source]"

      assert_select "input[name=?]", "yh_picture[credit]"

      assert_select "input[name=?]", "yh_picture[region]"

      assert_select "input[name=?]", "yh_picture[title]"

      assert_select "input[name=?]", "yh_picture[comment]"

      assert_select "input[name=?]", "yh_picture[body]"

      assert_select "input[name=?]", "yh_picture[file_name]"

      assert_select "input[name=?]", "yh_picture[taken_by]"
    end
  end
end
