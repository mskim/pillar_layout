require 'rails_helper'

RSpec.describe "comments/show", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :name => "Name",
      :text => "Text",
      :image => "Image",
      :x_value => 2.5,
      :y_value => 3.5,
      :width => 4.5,
      :height => 5.5,
      :proof => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(//)
  end
end
