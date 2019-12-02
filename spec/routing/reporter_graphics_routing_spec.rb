require "rails_helper"

RSpec.describe ReporterGraphicsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/reporter_graphics").to route_to("reporter_graphics#index")
    end

    it "routes to #new" do
      expect(:get => "/reporter_graphics/new").to route_to("reporter_graphics#new")
    end

    it "routes to #show" do
      expect(:get => "/reporter_graphics/1").to route_to("reporter_graphics#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/reporter_graphics/1/edit").to route_to("reporter_graphics#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/reporter_graphics").to route_to("reporter_graphics#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/reporter_graphics/1").to route_to("reporter_graphics#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/reporter_graphics/1").to route_to("reporter_graphics#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reporter_graphics/1").to route_to("reporter_graphics#destroy", :id => "1")
    end
  end
end
