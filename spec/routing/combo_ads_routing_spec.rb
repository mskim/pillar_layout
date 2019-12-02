require "rails_helper"

RSpec.describe ComboAdsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/combo_ads").to route_to("combo_ads#index")
    end

    it "routes to #new" do
      expect(:get => "/combo_ads/new").to route_to("combo_ads#new")
    end

    it "routes to #show" do
      expect(:get => "/combo_ads/1").to route_to("combo_ads#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/combo_ads/1/edit").to route_to("combo_ads#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/combo_ads").to route_to("combo_ads#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/combo_ads/1").to route_to("combo_ads#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/combo_ads/1").to route_to("combo_ads#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/combo_ads/1").to route_to("combo_ads#destroy", :id => "1")
    end
  end
end
