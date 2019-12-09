require 'rails_helper'

RSpec.describe "yh_pictures/index", type: :view do
  before(:each) do
    assign(:yh_pictures, [
      YhPicture.create!(
        :action => "Action",
        :service_type => "Service Type",
        :content_id => "Content",
        :urgency => "Urgency",
        :category => "Category",
        :class_code => "Class Code",
        :attriubute_code => "Attriubute Code",
        :source => "Source",
        :credit => "Credit",
        :page_ref => "page_ref",
        :title => "Title",
        :comment => "Comment",
        :body => "Bpdy",
        :file_name => "File Name",
        :taken_by => "Taken By"
      ),
      YhPicture.create!(
        :action => "Action",
        :service_type => "Service Type",
        :content_id => "Content",
        :urgency => "Urgency",
        :category => "Category",
        :class_code => "Class Code",
        :attriubute_code => "Attriubute Code",
        :source => "Source",
        :credit => "Credit",
        :page_ref => "page_ref",
        :title => "Title",
        :comment => "Comment",
        :body => "Bpdy",
        :file_name => "File Name",
        :taken_by => "Taken By"
      )
    ])
  end

  it "renders a list of yh_pictures" do
    render
    assert_select "tr>td", :text => "Action".to_s, :count => 2
    assert_select "tr>td", :text => "Service Type".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => "Urgency".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Class Code".to_s, :count => 2
    assert_select "tr>td", :text => "Attriubute Code".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Credit".to_s, :count => 2
    assert_select "tr>td", :text => "page_ref".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => "Bpdy".to_s, :count => 2
    assert_select "tr>td", :text => "File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Taken By".to_s, :count => 2
  end
end
