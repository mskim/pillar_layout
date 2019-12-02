require 'rails_helper'

RSpec.describe "YhGraphics", type: :request do
  describe "GET /yh_graphics" do
    it "works! (now write some real specs)" do
      get yh_graphics_path
      expect(response).to have_http_status(200)
    end
  end
end
