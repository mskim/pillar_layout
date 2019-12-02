require 'rails_helper'

RSpec.describe "ComboAds", type: :request do
  describe "GET /combo_ads" do
    it "works! (now write some real specs)" do
      get combo_ads_path
      expect(response).to have_http_status(200)
    end
  end
end
