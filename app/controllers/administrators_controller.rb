class AdministratorsController < ApplicationController
  #before_filter :is_admin?
  # GET /administrators
  # GET /administrators.json
  def index
    @administrators = Administrator.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /administrators/1
  # GET /administrators/1.json
  def show
    @administrator = Administrator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /administrators/new
  # GET /administrators/new.json
  def new
    @administrator = Administrator.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /administrators/1/edit
  def edit
    @administrator = Administrator.find(params[:id])
  end

  # POST /administrators
  # POST /administrators.json
  def create
    @administrator = Administrator.new(params[:administrator])

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to @administrator, notice: 'Administrator was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /administrators/1
  # PUT /administrators/1.json
  def update
    @administrator = Administrator.find(params[:id])

    respond_to do |format|
      if @administrator.update_attributes(params[:administrator])
        format.html { redirect_to @administrator, notice: 'Administrator was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /administrators/1
  # DELETE /administrators/1.json
  def destroy
    @administrator = Administrator.find(params[:id])
    @administrator.destroy

    respond_to do |format|
      format.html { redirect_to administrators_url }
    end
  end
  private
  def is_admin?
    return if Administrator.find_by_user_id(current_user)
    redirect_to root_path, notice: 'You must be an administrator for this action.'
  end
end
