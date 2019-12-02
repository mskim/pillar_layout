require 'rails_helper'

RSpec.describe "AdPlans", type: :request do
  describe "GET /ad_plans" do
    it "works! (now write some real specs)" do
      get ad_plans_path
      expect(response).to have_http_status(200)
    end
  end
end
