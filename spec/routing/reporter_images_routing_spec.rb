require "rails_helper"

RSpec.describe ReporterImagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/reporter_images").to route_to("reporter_images#index")
    end

    it "routes to #new" do
      expect(:get => "/reporter_images/new").to route_to("reporter_images#new")
    end

    it "routes to #show" do
      expect(:get => "/reporter_images/1").to route_to("reporter_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/reporter_images/1/edit").to route_to("reporter_images#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/reporter_images").to route_to("reporter_images#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/reporter_images/1").to route_to("reporter_images#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/reporter_images/1").to route_to("reporter_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reporter_images/1").to route_to("reporter_images#destroy", :id => "1")
    end
  end
end
