require 'rails_helper'

RSpec.describe "Graphics", type: :request do
  describe "GET /graphics" do
    it "works! (now write some real specs)" do
      get graphics_path
      expect(response).to have_http_status(200)
    end
  end
end
