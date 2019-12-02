require "rails_helper"

RSpec.describe YhPicturesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/yh_pictures").to route_to("yh_pictures#index")
    end

    it "routes to #new" do
      expect(:get => "/yh_pictures/new").to route_to("yh_pictures#new")
    end

    it "routes to #show" do
      expect(:get => "/yh_pictures/1").to route_to("yh_pictures#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/yh_pictures/1/edit").to route_to("yh_pictures#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/yh_pictures").to route_to("yh_pictures#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/yh_pictures/1").to route_to("yh_pictures#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/yh_pictures/1").to route_to("yh_pictures#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/yh_pictures/1").to route_to("yh_pictures#destroy", :id => "1")
    end
  end
end
