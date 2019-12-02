require 'rails_helper'

RSpec.describe "paragraphs/show", type: :view do
  before(:each) do
    @paragraph = assign(:paragraph, Paragraph.create!(
      :name => "Name",
      :working_article => nil,
      :order => 2,
      :para_text => "MyText",
      :tokens => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
