require 'rails_helper'

RSpec.describe "comments/index", type: :view do
  before(:each) do
    assign(:comments, [
      Comment.create!(
        :name => "Name",
        :text => "Text",
        :image => "Image",
        :x_value => 2.5,
        :y_value => 3.5,
        :width => 4.5,
        :height => 5.5,
        :proof => nil
      ),
      Comment.create!(
        :name => "Name",
        :text => "Text",
        :image => "Image",
        :x_value => 2.5,
        :y_value => 3.5,
        :width => 4.5,
        :height => 5.5,
        :proof => nil
      )
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
