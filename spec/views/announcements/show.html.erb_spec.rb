require 'rails_helper'

RSpec.describe "announcements/show", type: :view do
  before(:each) do
    @announcement = assign(:announcement, Announcement.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Kind/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Color/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
