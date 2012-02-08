class HiringManagersController < ApplicationController
  # GET /hiring_managers
  # GET /hiring_managers.json
  def index
    @hiring_managers = HiringManager.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /hiring_managers/1
  # GET /hiring_managers/1.json
  def show
    @hiring_manager = HiringManager.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /hiring_managers/new
  # GET /hiring_managers/new.json
  def new
    @hiring_manager = HiringManager.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /hiring_managers/1/edit
  def edit
    @hiring_manager = HiringManager.find(params[:id])
  end

  # POST /hiring_managers
  # POST /hiring_managers.json
  def create
    @hiring_manager = HiringManager.new(params[:hiring_manager])

    respond_to do |format|
      if @hiring_manager.save
        format.html { redirect_to @hiring_manager, notice: 'Hiring manager was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /hiring_managers/1
  # PUT /hiring_managers/1.json
  def update
    @hiring_manager = HiringManager.find(params[:id])

    respond_to do |format|
      if @hiring_manager.update_attributes(params[:hiring_manager])
        format.html { redirect_to @hiring_manager, notice: 'Hiring manager was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /hiring_managers/1
  # DELETE /hiring_managers/1.json
  def destroy
    @hiring_manager = HiringManager.find(params[:id])
    @hiring_manager.destroy

    respond_to do |format|
      format.html { redirect_to hiring_managers_url }
    end
  end
end
