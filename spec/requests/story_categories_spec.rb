require 'rails_helper'

RSpec.describe "StoryCategories", type: :request do
  describe "GET /story_categories" do
    it "works! (now write some real specs)" do
      get story_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
