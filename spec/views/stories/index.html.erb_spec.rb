require 'rails_helper'

RSpec.describe "stories/index", type: :view do
  before(:each) do
    assign(:stories, [
      Story.create!(
        :user => nil,
        :working_article => nil,
        :reporter => "Reporter",
        :group => "Group",
        :title => "Title",
        :subtitle => "Subtitle",
        :body => "Body",
        :quote => "Quote",
        :status => "Status",
        :char_count => 2,
        :published => false,
        :path => "Path"
      ),
      Story.create!(
        :user => nil,
        :working_article => nil,
        :reporter => "Reporter",
        :group => "Group",
        :title => "Title",
        :subtitle => "Subtitle",
        :body => "Body",
        :quote => "Quote",
        :status => "Status",
        :char_count => 2,
        :published => false,
        :path => "Path"
      )
    ])
  end

  it "renders a list of stories" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Reporter".to_s, :count => 2
    assert_select "tr>td", :text => "Group".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Subtitle".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
    assert_select "tr>td", :text => "Quote".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
  end
end
