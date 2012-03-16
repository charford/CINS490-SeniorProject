class ActiveusersController < ApplicationController
  
  # GET /activeusers
  # GET /activeusers.json
  def index
    @activeusers = Activeuser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activeusers }
    end
  end

  # GET /activeusers/1
  # GET /activeusers/1.json
  def show
    @activeuser = Activeuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activeuser }
    end
  end

  # GET /activeusers/new
  # GET /activeusers/new.json
  def new
    @activeuser = Activeuser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activeuser }
    end
  end

  # GET /activeusers/1/edit
  def edit
    @activeuser = Activeuser.find(params[:id])
  end

  # POST /activeusers
  # POST /activeusers.json
  def create
    @activeuser = Activeuser.new(params[:activeuser])

    respond_to do |format|
      if @activeuser.save
        format.html { redirect_to @activeuser, notice: 'Activeuser was successfully created.' }
        format.json { render json: @activeuser, status: :created, location: @activeuser }
      else
        format.html { render action: "new" }
        format.json { render json: @activeuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activeusers/1
  # PUT /activeusers/1.json
  def update
    @activeuser = Activeuser.find(params[:id])

    respond_to do |format|
      if @activeuser.update_attributes(params[:activeuser])
        format.html { redirect_to @activeuser, notice: 'Activeuser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activeuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activeusers/1
  # DELETE /activeusers/1.json
  def destroy
    @activeuser = Activeuser.find(params[:id])
    @activeuser.destroy

    respond_to do |format|
      format.html { redirect_to activeusers_url }
      format.json { head :no_content }
    end
  end
end
