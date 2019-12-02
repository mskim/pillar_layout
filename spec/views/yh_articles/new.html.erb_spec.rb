require 'rails_helper'

RSpec.describe "yh_articles/new", type: :view do
  before(:each) do
    assign(:yh_article, YhArticle.new(
      :action => "MyString",
      :service_type => "MyString",
      :content_id => "MyString",
      :time => "MyString",
      :urgency => "MyString",
      :category => "MyString",
      :class_code => "MyString",
      :attriubute_code => "MyString",
      :source => "MyString",
      :credit => "MyString",
      :region => "MyString",
      :title => "MyString",
      :body => "MyText",
      :writer => "MyString",
      :char_count => 1,
      :taken_by => "MyString"
    ))
  end

  it "renders new yh_article form" do
    render

    assert_select "form[action=?][method=?]", yh_articles_path, "post" do

      assert_select "input[name=?]", "yh_article[action]"

      assert_select "input[name=?]", "yh_article[service_type]"

      assert_select "input[name=?]", "yh_article[content_id]"

      assert_select "input[name=?]", "yh_article[time]"

      assert_select "input[name=?]", "yh_article[urgency]"

      assert_select "input[name=?]", "yh_article[category]"

      assert_select "input[name=?]", "yh_article[class_code]"

      assert_select "input[name=?]", "yh_article[attriubute_code]"

      assert_select "input[name=?]", "yh_article[source]"

      assert_select "input[name=?]", "yh_article[credit]"

      assert_select "input[name=?]", "yh_article[region]"

      assert_select "input[name=?]", "yh_article[title]"

      assert_select "textarea[name=?]", "yh_article[body]"

      assert_select "input[name=?]", "yh_article[writer]"

      assert_select "input[name=?]", "yh_article[char_count]"

      assert_select "input[name=?]", "yh_article[taken_by]"
    end
  end
end
