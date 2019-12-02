require 'rails_helper'

RSpec.describe "LayoutNodes", type: :request do
  describe "GET /layout_nodes" do
    it "works! (now write some real specs)" do
      get layout_nodes_path
      expect(response).to have_http_status(200)
    end
  end
end
