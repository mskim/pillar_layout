require 'rails_helper'

RSpec.describe "proofs/new", type: :view do
  before(:each) do
    assign(:proof, Proof.new(
      :working_article => nil
    ))
  end

  it "renders new proof form" do
    render

    assert_select "form[action=?][method=?]", proofs_path, "post" do

      assert_select "input[name=?]", "proof[working_article_id]"
    end
  end
end
