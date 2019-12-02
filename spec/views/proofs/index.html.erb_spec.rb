require 'rails_helper'

RSpec.describe "proofs/index", type: :view do
  before(:each) do
    assign(:proofs, [
      Proof.create!(
        :working_article => nil
      ),
      Proof.create!(
        :working_article => nil
      )
    ])
  end

  it "renders a list of proofs" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
