require "rails_helper"

RSpec.describe SpreadAdBoxesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/spread_ad_boxes").to route_to("spread_ad_boxes#index")
    end

    it "routes to #new" do
      expect(:get => "/spread_ad_boxes/new").to route_to("spread_ad_boxes#new")
    end

    it "routes to #show" do
      expect(:get => "/spread_ad_boxes/1").to route_to("spread_ad_boxes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/spread_ad_boxes/1/edit").to route_to("spread_ad_boxes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/spread_ad_boxes").to route_to("spread_ad_boxes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/spread_ad_boxes/1").to route_to("spread_ad_boxes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/spread_ad_boxes/1").to route_to("spread_ad_boxes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/spread_ad_boxes/1").to route_to("spread_ad_boxes#destroy", :id => "1")
    end
  end
end
