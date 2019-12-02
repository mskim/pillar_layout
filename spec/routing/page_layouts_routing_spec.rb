require "rails_helper"

RSpec.describe PageLayoutsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/page_layouts").to route_to("page_layouts#index")
    end

    it "routes to #new" do
      expect(:get => "/page_layouts/new").to route_to("page_layouts#new")
    end

    it "routes to #show" do
      expect(:get => "/page_layouts/1").to route_to("page_layouts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/page_layouts/1/edit").to route_to("page_layouts#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/page_layouts").to route_to("page_layouts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/page_layouts/1").to route_to("page_layouts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/page_layouts/1").to route_to("page_layouts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/page_layouts/1").to route_to("page_layouts#destroy", :id => "1")
    end
  end
end
