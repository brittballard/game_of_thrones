require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CharectersController do

  # This should return the minimal set of attributes required to create a valid
  # Charecter. As you add validations to Charecter, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CharectersController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all charecters as @charecters" do
      charecter = Charecter.create! valid_attributes
      get :index, {}, valid_session
      assigns(:charecters).should eq([charecter])
    end
  end

  describe "GET show" do
    it "assigns the requested charecter as @charecter" do
      charecter = Charecter.create! valid_attributes
      get :show, {:id => charecter.to_param}, valid_session
      assigns(:charecter).should eq(charecter)
    end
  end

  describe "GET new" do
    it "assigns a new charecter as @charecter" do
      get :new, {}, valid_session
      assigns(:charecter).should be_a_new(Charecter)
    end
  end

  describe "GET edit" do
    it "assigns the requested charecter as @charecter" do
      charecter = Charecter.create! valid_attributes
      get :edit, {:id => charecter.to_param}, valid_session
      assigns(:charecter).should eq(charecter)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Charecter" do
        expect {
          post :create, {:charecter => valid_attributes}, valid_session
        }.to change(Charecter, :count).by(1)
      end

      it "assigns a newly created charecter as @charecter" do
        post :create, {:charecter => valid_attributes}, valid_session
        assigns(:charecter).should be_a(Charecter)
        assigns(:charecter).should be_persisted
      end

      it "redirects to the created charecter" do
        post :create, {:charecter => valid_attributes}, valid_session
        response.should redirect_to(Charecter.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved charecter as @charecter" do
        # Trigger the behavior that occurs when invalid params are submitted
        Charecter.any_instance.stub(:save).and_return(false)
        post :create, {:charecter => {}}, valid_session
        assigns(:charecter).should be_a_new(Charecter)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Charecter.any_instance.stub(:save).and_return(false)
        post :create, {:charecter => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested charecter" do
        charecter = Charecter.create! valid_attributes
        # Assuming there are no other charecters in the database, this
        # specifies that the Charecter created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Charecter.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => charecter.to_param, :charecter => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested charecter as @charecter" do
        charecter = Charecter.create! valid_attributes
        put :update, {:id => charecter.to_param, :charecter => valid_attributes}, valid_session
        assigns(:charecter).should eq(charecter)
      end

      it "redirects to the charecter" do
        charecter = Charecter.create! valid_attributes
        put :update, {:id => charecter.to_param, :charecter => valid_attributes}, valid_session
        response.should redirect_to(charecter)
      end
    end

    describe "with invalid params" do
      it "assigns the charecter as @charecter" do
        charecter = Charecter.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Charecter.any_instance.stub(:save).and_return(false)
        put :update, {:id => charecter.to_param, :charecter => {}}, valid_session
        assigns(:charecter).should eq(charecter)
      end

      it "re-renders the 'edit' template" do
        charecter = Charecter.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Charecter.any_instance.stub(:save).and_return(false)
        put :update, {:id => charecter.to_param, :charecter => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested charecter" do
      charecter = Charecter.create! valid_attributes
      expect {
        delete :destroy, {:id => charecter.to_param}, valid_session
      }.to change(Charecter, :count).by(-1)
    end

    it "redirects to the charecters list" do
      charecter = Charecter.create! valid_attributes
      delete :destroy, {:id => charecter.to_param}, valid_session
      response.should redirect_to(charecters_url)
    end
  end

end
