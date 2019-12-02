require "rails_helper"

RSpec.describe LayoutNodesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/layout_nodes").to route_to("layout_nodes#index")
    end

    it "routes to #new" do
      expect(:get => "/layout_nodes/new").to route_to("layout_nodes#new")
    end

    it "routes to #show" do
      expect(:get => "/layout_nodes/1").to route_to("layout_nodes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/layout_nodes/1/edit").to route_to("layout_nodes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/layout_nodes").to route_to("layout_nodes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/layout_nodes/1").to route_to("layout_nodes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/layout_nodes/1").to route_to("layout_nodes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/layout_nodes/1").to route_to("layout_nodes#destroy", :id => "1")
    end
  end
end
