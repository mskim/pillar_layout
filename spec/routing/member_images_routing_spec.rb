require "rails_helper"

RSpec.describe MemberImagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/member_images").to route_to("member_images#index")
    end

    it "routes to #new" do
      expect(:get => "/member_images/new").to route_to("member_images#new")
    end

    it "routes to #show" do
      expect(:get => "/member_images/1").to route_to("member_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/member_images/1/edit").to route_to("member_images#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/member_images").to route_to("member_images#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/member_images/1").to route_to("member_images#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/member_images/1").to route_to("member_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/member_images/1").to route_to("member_images#destroy", :id => "1")
    end
  end
end
