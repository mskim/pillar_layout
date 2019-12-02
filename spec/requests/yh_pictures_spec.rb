require 'rails_helper'

RSpec.describe "YhPictures", type: :request do
  describe "GET /yh_pictures" do
    it "works! (now write some real specs)" do
      get yh_pictures_path
      expect(response).to have_http_status(200)
    end
  end
end
