require 'rails_helper'

RSpec.describe "PageLayouts", type: :request do
  describe "GET /page_layouts" do
    it "works! (now write some real specs)" do
      get page_layouts_path
      expect(response).to have_http_status(200)
    end
  end
end
