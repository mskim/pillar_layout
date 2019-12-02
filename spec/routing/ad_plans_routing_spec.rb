require "rails_helper"

RSpec.describe AdPlansController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/ad_plans").to route_to("ad_plans#index")
    end

    it "routes to #new" do
      expect(:get => "/ad_plans/new").to route_to("ad_plans#new")
    end

    it "routes to #show" do
      expect(:get => "/ad_plans/1").to route_to("ad_plans#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ad_plans/1/edit").to route_to("ad_plans#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/ad_plans").to route_to("ad_plans#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ad_plans/1").to route_to("ad_plans#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ad_plans/1").to route_to("ad_plans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ad_plans/1").to route_to("ad_plans#destroy", :id => "1")
    end
  end
end
