require 'rails_helper'

RSpec.describe "MemberImages", type: :request do
  describe "GET /member_images" do
    it "works! (now write some real specs)" do
      get member_images_path
      expect(response).to have_http_status(200)
    end
  end
end
