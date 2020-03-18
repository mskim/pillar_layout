require 'rails_helper'

RSpec.describe "SpreadAdBoxes", type: :request do
  describe "GET /spread_ad_boxes" do
    it "works! (now write some real specs)" do
      get spread_ad_boxes_path
      expect(response).to have_http_status(200)
    end
  end
end
