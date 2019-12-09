require "rails_helper"

RSpec.describe BodyLinesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/body_lines").to route_to("body_lines#index")
    end

    it "routes to #new" do
      expect(:get => "/body_lines/new").to route_to("body_lines#new")
    end

    it "routes to #show" do
      expect(:get => "/body_lines/1").to route_to("body_lines#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/body_lines/1/edit").to route_to("body_lines#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/body_lines").to route_to("body_lines#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/body_lines/1").to route_to("body_lines#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/body_lines/1").to route_to("body_lines#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/body_lines/1").to route_to("body_lines#destroy", :id => "1")
    end
  end
end
