require 'rails_helper'

RSpec.describe "paragraphs/edit", type: :view do
  before(:each) do
    @paragraph = assign(:paragraph, Paragraph.create!(
      :name => "MyString",
      :working_article => nil,
      :order => 1,
      :para_text => "MyText",
      :tokens => "MyText"
    ))
  end

  it "renders the edit paragraph form" do
    render

    assert_select "form[action=?][method=?]", paragraph_path(@paragraph), "post" do

      assert_select "input[name=?]", "paragraph[name]"

      assert_select "input[name=?]", "paragraph[working_article_id]"

      assert_select "input[name=?]", "paragraph[order]"

      assert_select "textarea[name=?]", "paragraph[para_text]"

      assert_select "textarea[name=?]", "paragraph[tokens]"
    end
  end
end
