require 'rails_helper'

RSpec.describe "ExpertWriters", type: :request do
  describe "GET /expert_writers" do
    it "works! (now write some real specs)" do
      get expert_writers_path
      expect(response).to have_http_status(200)
    end
  end
end
