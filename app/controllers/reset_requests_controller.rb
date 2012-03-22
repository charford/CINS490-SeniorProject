class ResetRequestsController < ApplicationController
  # GET /reset_requests
  # GET /reset_requests.json
  def index
    @reset_requests = ResetRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reset_requests }
    end
  end

  # GET /reset_requests/1
  # GET /reset_requests/1.json
  def show
    @reset_request = ResetRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reset_request }
    end
  end

  # GET /reset_requests/new
  # GET /reset_requests/new.json
  def new
    @reset_request = ResetRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reset_request }
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
        format.html { redirect_to @reset_request, notice: 'Reset request was successfully created.' }
        format.json { render json: @reset_request, status: :created, location: @reset_request }
      else
        format.html { render action: "new" }
        format.json { render json: @reset_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reset_requests/1
  # PUT /reset_requests/1.json
  def update
    @reset_request = ResetRequest.find(params[:id])

    respond_to do |format|
      if @reset_request.update_attributes(params[:reset_request])
        format.html { redirect_to @reset_request, notice: 'Reset request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reset_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reset_requests/1
  # DELETE /reset_requests/1.json
  def destroy
    @reset_request = ResetRequest.find(params[:id])
    @reset_request.destroy

    respond_to do |format|
      format.html { redirect_to reset_requests_url }
      format.json { head :no_content }
    end
  end
end
