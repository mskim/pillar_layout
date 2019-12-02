require "rails_helper"

RSpec.describe StorySubcategoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/story_subcategories").to route_to("story_subcategories#index")
    end

    it "routes to #new" do
      expect(:get => "/story_subcategories/new").to route_to("story_subcategories#new")
    end

    it "routes to #show" do
      expect(:get => "/story_subcategories/1").to route_to("story_subcategories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/story_subcategories/1/edit").to route_to("story_subcategories#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/story_subcategories").to route_to("story_subcategories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/story_subcategories/1").to route_to("story_subcategories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/story_subcategories/1").to route_to("story_subcategories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/story_subcategories/1").to route_to("story_subcategories#destroy", :id => "1")
    end
  end
end
