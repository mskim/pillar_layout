require 'rails_helper'

RSpec.describe "YhArticles", type: :request do
  describe "GET /yh_articles" do
    it "works! (now write some real specs)" do
      get yh_articles_path
      expect(response).to have_http_status(200)
    end
  end
end
