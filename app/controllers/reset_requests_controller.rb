class ResetRequestsController < ApplicationController

  def clean_up
    
  end

  # GET /reset_requests
  # GET /reset_requests.json
  def index
    @reset_requests = ResetRequest.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /reset_requests/1
  # GET /reset_requests/1.json
  def show
    @reset_request = ResetRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /reset_requests/new
  # GET /reset_requests/new.json
  def new
    @reset_request = ResetRequest.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /reset_requests/1/edit
  def edit
    @reset_request = ResetRequest.find(params[:id])
  end

  # POST /reset_requests
  # POST /reset_requests.json
  def create
    @reset_request = ResetRequest.new(params[:reset_request])

    respond_to do |format|
      if @reset_request.save
        format.html { redirect_to @reset_request, :only_path => true, notice: 'Reset request was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /reset_requests/1
  # PUT /reset_requests/1.json
  def update
    @reset_request = ResetRequest.find(params[:id])

    respond_to do |format|
      if @reset_request.update_attributes(params[:reset_request])
        format.html { redirect_to @reset_request, :only_path => true, notice: 'Reset request was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /reset_requests/1
  # DELETE /reset_requests/1.json
  def destroy
    @reset_request = ResetRequest.find(params[:id])
    @reset_request.destroy

    respond_to do |format|
      format.html { redirect_to reset_requests_url, :only_path => true }
    end
  end
end
