require 'rails_helper'

RSpec.describe "BodyLines", type: :request do
  describe "GET /body_lines" do
    it "works! (now write some real specs)" do
      get body_lines_path
      expect(response).to have_http_status(200)
    end
  end
end
