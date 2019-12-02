require 'rails_helper'

RSpec.describe "Pillars", type: :request do
  describe "GET /pillars" do
    it "works! (now write some real specs)" do
      get pillars_path
      expect(response).to have_http_status(200)
    end
  end
end
