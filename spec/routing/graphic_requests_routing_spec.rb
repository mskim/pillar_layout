require "rails_helper"

RSpec.describe GraphicRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/graphic_requests").to route_to("graphic_requests#index")
    end

    it "routes to #new" do
      expect(:get => "/graphic_requests/new").to route_to("graphic_requests#new")
    end

    it "routes to #show" do
      expect(:get => "/graphic_requests/1").to route_to("graphic_requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/graphic_requests/1/edit").to route_to("graphic_requests#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/graphic_requests").to route_to("graphic_requests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/graphic_requests/1").to route_to("graphic_requests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/graphic_requests/1").to route_to("graphic_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/graphic_requests/1").to route_to("graphic_requests#destroy", :id => "1")
    end
  end
end
