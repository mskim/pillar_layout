require 'rails_helper'

RSpec.describe "Paragraphs", type: :request do
  describe "GET /paragraphs" do
    it "works! (now write some real specs)" do
      get paragraphs_path
      expect(response).to have_http_status(200)
    end
  end
end
