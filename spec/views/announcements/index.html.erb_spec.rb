require 'rails_helper'

RSpec.describe "announcements/index", type: :view do
  before(:each) do
    assign(:announcements, [
      Announcement.create!(
        :name => "Name",
        :kind => "Kind",
        :title => "Title",
        :subtitle => "Subtitle",
        :column => 2,
        :lines => 3,
        :page => 4,
        :color => "Color",
        :script => "MyText",
        :publication => nil
      ),
      Announcement.create!(
        :name => "Name",
        :kind => "Kind",
        :title => "Title",
        :subtitle => "Subtitle",
        :column => 2,
        :lines => 3,
        :page => 4,
        :color => "Color",
        :script => "MyText",
        :publication => nil
      )
    ])
  end

  it "renders a list of announcements" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Subtitle".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
