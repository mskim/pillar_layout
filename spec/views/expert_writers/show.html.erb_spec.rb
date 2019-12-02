require 'rails_helper'

RSpec.describe "expert_writers/show", type: :view do
  before(:each) do
    @expert_writer = assign(:expert_writer, ExpertWriter.create!(
      :name => "Name",
      :work => "Work",
      :position => "Position",
      :email => "Email",
      :category_code => "Category Code",
      :expert_image => "Expert Image",
      :expert_jpg_image => "Expert Jpg Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Work/)
    expect(rendered).to match(/Position/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Category Code/)
    expect(rendered).to match(/Expert Image/)
    expect(rendered).to match(/Expert Jpg Image/)
  end
end
