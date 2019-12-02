require "rails_helper"

RSpec.describe PillarsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/pillars").to route_to("pillars#index")
    end

    it "routes to #new" do
      expect(:get => "/pillars/new").to route_to("pillars#new")
    end

    it "routes to #show" do
      expect(:get => "/pillars/1").to route_to("pillars#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pillars/1/edit").to route_to("pillars#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/pillars").to route_to("pillars#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pillars/1").to route_to("pillars#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pillars/1").to route_to("pillars#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pillars/1").to route_to("pillars#destroy", :id => "1")
    end
  end
end
