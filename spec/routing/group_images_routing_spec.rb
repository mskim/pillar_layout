require "rails_helper"

RSpec.describe GroupImagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/group_images").to route_to("group_images#index")
    end

    it "routes to #new" do
      expect(:get => "/group_images/new").to route_to("group_images#new")
    end

    it "routes to #show" do
      expect(:get => "/group_images/1").to route_to("group_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/group_images/1/edit").to route_to("group_images#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/group_images").to route_to("group_images#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/group_images/1").to route_to("group_images#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/group_images/1").to route_to("group_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/group_images/1").to route_to("group_images#destroy", :id => "1")
    end
  end
end
