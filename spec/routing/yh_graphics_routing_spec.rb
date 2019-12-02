require "rails_helper"

RSpec.describe YhGraphicsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/yh_graphics").to route_to("yh_graphics#index")
    end

    it "routes to #new" do
      expect(:get => "/yh_graphics/new").to route_to("yh_graphics#new")
    end

    it "routes to #show" do
      expect(:get => "/yh_graphics/1").to route_to("yh_graphics#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/yh_graphics/1/edit").to route_to("yh_graphics#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/yh_graphics").to route_to("yh_graphics#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/yh_graphics/1").to route_to("yh_graphics#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/yh_graphics/1").to route_to("yh_graphics#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/yh_graphics/1").to route_to("yh_graphics#destroy", :id => "1")
    end
  end
end
