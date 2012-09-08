require "spec_helper"

describe CharectersController do
  describe "routing" do

    it "routes to #index" do
      get("/charecters").should route_to("charecters#index")
    end

    it "routes to #new" do
      get("/charecters/new").should route_to("charecters#new")
    end

    it "routes to #show" do
      get("/charecters/1").should route_to("charecters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/charecters/1/edit").should route_to("charecters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/charecters").should route_to("charecters#create")
    end

    it "routes to #update" do
      put("/charecters/1").should route_to("charecters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/charecters/1").should route_to("charecters#destroy", :id => "1")
    end

  end
end
