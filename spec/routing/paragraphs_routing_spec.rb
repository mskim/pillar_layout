require "rails_helper"

RSpec.describe ParagraphsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/paragraphs").to route_to("paragraphs#index")
    end

    it "routes to #new" do
      expect(:get => "/paragraphs/new").to route_to("paragraphs#new")
    end

    it "routes to #show" do
      expect(:get => "/paragraphs/1").to route_to("paragraphs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/paragraphs/1/edit").to route_to("paragraphs#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/paragraphs").to route_to("paragraphs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/paragraphs/1").to route_to("paragraphs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/paragraphs/1").to route_to("paragraphs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/paragraphs/1").to route_to("paragraphs#destroy", :id => "1")
    end
  end
end
