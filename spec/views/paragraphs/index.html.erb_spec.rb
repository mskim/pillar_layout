require 'rails_helper'

RSpec.describe "paragraphs/index", type: :view do
  before(:each) do
    assign(:paragraphs, [
      Paragraph.create!(
        :name => "Name",
        :working_article => nil,
        :order => 2,
        :para_text => "MyText",
        :tokens => "MyText"
      ),
      Paragraph.create!(
        :name => "Name",
        :working_article => nil,
        :order => 2,
        :para_text => "MyText",
        :tokens => "MyText"
      )
    ])
  end

  it "renders a list of paragraphs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
