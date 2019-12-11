require 'rails_helper'

RSpec.describe "yh_articles/index", type: :view do
  before(:each) do
    assign(:yh_articles, [
      YhArticle.create!(
        :action => "Action",
        :service_type => "Service Type",
        :content_id => "Content",
        :time => "Time",
        :urgency => "Urgency",
        :category => "Category",
        :class_code => "Class Code",
        :attriubute_code => "Attriubute Code",
        :source => "Source",
        :credit => "Credit",
        :region => "region",
        :title => "Title",
        :body => "MyText",
        :writer => "Writer",
        :char_count => 2,
        :taken_by => "Taken By"
      ),
      YhArticle.create!(
        :action => "Action",
        :service_type => "Service Type",
        :content_id => "Content",
        :time => "Time",
        :urgency => "Urgency",
        :category => "Category",
        :class_code => "Class Code",
        :attriubute_code => "Attriubute Code",
        :source => "Source",
        :credit => "Credit",
        :region => "region",
        :title => "Title",
        :body => "MyText",
        :writer => "Writer",
        :char_count => 2,
        :taken_by => "Taken By"
      )
    ])
  end

  it "renders a list of yh_articles" do
    render
    assert_select "tr>td", :text => "Action".to_s, :count => 2
    assert_select "tr>td", :text => "Service Type".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => "Time".to_s, :count => 2
    assert_select "tr>td", :text => "Urgency".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Class Code".to_s, :count => 2
    assert_select "tr>td", :text => "Attriubute Code".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Credit".to_s, :count => 2
    assert_select "tr>td", :text => "region".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Writer".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Taken By".to_s, :count => 2
  end
end
