require 'rails_helper'

RSpec.describe "yh_articles/show", type: :view do
  before(:each) do
    @yh_article = assign(:yh_article, YhArticle.create!(
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
      :page_ref => "page_ref",
      :title => "Title",
      :body => "MyText",
      :writer => "Writer",
      :char_count => 2,
      :taken_by => "Taken By"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Action/)
    expect(rendered).to match(/Service Type/)
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/Time/)
    expect(rendered).to match(/Urgency/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/Class Code/)
    expect(rendered).to match(/Attriubute Code/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/Credit/)
    expect(rendered).to match(/page_ref/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Writer/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Taken By/)
  end
end
