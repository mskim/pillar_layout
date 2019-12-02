require 'rails_helper'

RSpec.describe "proofs/show", type: :view do
  before(:each) do
    @proof = assign(:proof, Proof.create!(
      :working_article => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
