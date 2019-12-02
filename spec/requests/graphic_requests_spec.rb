require 'rails_helper'

RSpec.describe "GraphicRequests", type: :request do
  describe "GET /graphic_requests" do
    it "works! (now write some real specs)" do
      get graphic_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
