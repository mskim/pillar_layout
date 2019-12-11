require 'rails_helper'

RSpec.describe "yh_pictures/show", type: :view do
  before(:each) do
    @yh_picture = assign(:yh_picture, YhPicture.create!(
      :action => "Action",
      :service_type => "Service Type",
      :content_id => "Content",
      :urgency => "Urgency",
      :category => "Category",
      :class_code => "Class Code",
      :attriubute_code => "Attriubute Code",
      :source => "Source",
      :credit => "Credit",
      :region => "region",
      :title => "Title",
      :comment => "Comment",
      :body => "Bpdy",
      :file_name => "File Name",
      :taken_by => "Taken By"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Action/)
    expect(rendered).to match(/Service Type/)
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/Urgency/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/Class Code/)
    expect(rendered).to match(/Attriubute Code/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/Credit/)
    expect(rendered).to match(/region/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Comment/)
    expect(rendered).to match(/Bpdy/)
    expect(rendered).to match(/File Name/)
    expect(rendered).to match(/Taken By/)
  end
end
