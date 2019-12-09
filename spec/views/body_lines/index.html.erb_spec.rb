require 'rails_helper'

RSpec.describe "body_lines/index", type: :view do
  before(:each) do
    assign(:body_lines, [
      BodyLine.create!(
        :order => 2,
        :x => 3.5,
        :y => "",
        :width => 4.5,
        :height => 5.5,
        :coulumn => 6,
        :line_number => 7,
        :tokens => "MyText",
        :overflow => "",
        :working_aticle => nil
      ),
      BodyLine.create!(
        :order => 2,
        :x => 3.5,
        :y => "",
        :width => 4.5,
        :height => 5.5,
        :coulumn => 6,
        :line_number => 7,
        :tokens => "MyText",
        :overflow => "",
        :working_aticle => nil
      )
    ])
  end

  it "renders a list of body_lines" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
