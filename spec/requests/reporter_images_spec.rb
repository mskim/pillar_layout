require 'rails_helper'

RSpec.describe "ReporterImages", type: :request do
  describe "GET /reporter_images" do
    it "works! (now write some real specs)" do
      get reporter_images_path
      expect(response).to have_http_status(200)
    end
  end
end
