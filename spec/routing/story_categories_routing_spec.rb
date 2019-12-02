require "rails_helper"

RSpec.describe StoryCategoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/story_categories").to route_to("story_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/story_categories/new").to route_to("story_categories#new")
    end

    it "routes to #show" do
      expect(:get => "/story_categories/1").to route_to("story_categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/story_categories/1/edit").to route_to("story_categories#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/story_categories").to route_to("story_categories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/story_categories/1").to route_to("story_categories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/story_categories/1").to route_to("story_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/story_categories/1").to route_to("story_categories#destroy", :id => "1")
    end
  end
end
