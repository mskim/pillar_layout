require "rails_helper"

RSpec.describe AdBookingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/ad_bookings").to route_to("ad_bookings#index")
    end

    it "routes to #new" do
      expect(:get => "/ad_bookings/new").to route_to("ad_bookings#new")
    end

    it "routes to #show" do
      expect(:get => "/ad_bookings/1").to route_to("ad_bookings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ad_bookings/1/edit").to route_to("ad_bookings#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/ad_bookings").to route_to("ad_bookings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ad_bookings/1").to route_to("ad_bookings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ad_bookings/1").to route_to("ad_bookings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ad_bookings/1").to route_to("ad_bookings#destroy", :id => "1")
    end
  end
end
