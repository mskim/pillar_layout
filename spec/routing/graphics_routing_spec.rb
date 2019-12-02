require "rails_helper"

RSpec.describe GraphicsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/graphics").to route_to("graphics#index")
    end

    it "routes to #new" do
      expect(:get => "/graphics/new").to route_to("graphics#new")
    end

    it "routes to #show" do
      expect(:get => "/graphics/1").to route_to("graphics#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/graphics/1/edit").to route_to("graphics#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/graphics").to route_to("graphics#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/graphics/1").to route_to("graphics#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/graphics/1").to route_to("graphics#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/graphics/1").to route_to("graphics#destroy", :id => "1")
    end
  end
end
