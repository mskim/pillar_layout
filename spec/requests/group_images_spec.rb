require 'rails_helper'

RSpec.describe "GroupImages", type: :request do
  describe "GET /group_images" do
    it "works! (now write some real specs)" do
      get group_images_path
      expect(response).to have_http_status(200)
    end
  end
end
