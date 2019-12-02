require 'rails_helper'

RSpec.describe "paragraphs/new", type: :view do
  before(:each) do
    assign(:paragraph, Paragraph.new(
      :name => "MyString",
      :working_article => nil,
      :order => 1,
      :para_text => "MyText",
      :tokens => "MyText"
    ))
  end

  it "renders new paragraph form" do
    render

    assert_select "form[action=?][method=?]", paragraphs_path, "post" do

      assert_select "input[name=?]", "paragraph[name]"

      assert_select "input[name=?]", "paragraph[working_article_id]"

      assert_select "input[name=?]", "paragraph[order]"

      assert_select "textarea[name=?]", "paragraph[para_text]"

      assert_select "textarea[name=?]", "paragraph[tokens]"
    end
  end
end
