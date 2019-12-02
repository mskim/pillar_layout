require "rails_helper"

RSpec.describe LineFragmentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/line_fragments").to route_to("line_fragments#index")
    end

    it "routes to #new" do
      expect(:get => "/line_fragments/new").to route_to("line_fragments#new")
    end

    it "routes to #show" do
      expect(:get => "/line_fragments/1").to route_to("line_fragments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/line_fragments/1/edit").to route_to("line_fragments#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/line_fragments").to route_to("line_fragments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/line_fragments/1").to route_to("line_fragments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/line_fragments/1").to route_to("line_fragments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/line_fragments/1").to route_to("line_fragments#destroy", :id => "1")
    end
  end
end
