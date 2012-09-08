class CharectersController < ApplicationController
  # GET /charecters
  # GET /charecters.json
  def index
    @charecters = Charecter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @charecters }
    end
  end

  # GET /charecters/1
  # GET /charecters/1.json
  def show
    @charecter = Charecter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @charecter }
    end
  end

  # GET /charecters/new
  # GET /charecters/new.json
  def new
    @charecter = Charecter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @charecter }
    end
  end

  # GET /charecters/1/edit
  def edit
    @charecter = Charecter.find(params[:id])
  end

  # POST /charecters
  # POST /charecters.json
  def create
    @charecter = Charecter.new(params[:charecter])

    respond_to do |format|
      if @charecter.save
        format.html { redirect_to @charecter, notice: 'Charecter was successfully created.' }
        format.json { render json: @charecter, status: :created, location: @charecter }
      else
        format.html { render action: "new" }
        format.json { render json: @charecter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charecters/1
  # PUT /charecters/1.json
  def update
    @charecter = Charecter.find(params[:id])

    respond_to do |format|
      if @charecter.update_attributes(params[:charecter])
        format.html { redirect_to @charecter, notice: 'Charecter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @charecter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charecters/1
  # DELETE /charecters/1.json
  def destroy
    @charecter = Charecter.find(params[:id])
    @charecter.destroy

    respond_to do |format|
      format.html { redirect_to charecters_url }
      format.json { head :no_content }
    end
  end
end
