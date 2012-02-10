class ApplicantResponsesController < ApplicationController
  # GET /applicant_responses
  # GET /applicant_responses.json
  def index
    @applicant_responses = ApplicantResponse.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applicant_responses }
    end
  end

  # GET /applicant_responses/1
  # GET /applicant_responses/1.json
  def show
    @applicant_response = ApplicantResponse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @applicant_response }
    end
  end

  # GET /applicant_responses/new
  # GET /applicant_responses/new.json
  def new
    @applicant_response = ApplicantResponse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @applicant_response }
    end
  end

  # GET /applicant_responses/1/edit
  def edit
    @applicant_response = ApplicantResponse.find(params[:id])
  end

  # POST /applicant_responses
  # POST /applicant_responses.json
  def create
    @applicant_response = ApplicantResponse.new(params[:applicant_response])

    respond_to do |format|
      if @applicant_response.save
        format.html { redirect_to @applicant_response, notice: 'Applicant response was successfully created.' }
        format.json { render json: @applicant_response, status: :created, location: @applicant_response }
      else
        format.html { render action: "new" }
        format.json { render json: @applicant_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /applicant_responses/1
  # PUT /applicant_responses/1.json
  def update
    @applicant_response = ApplicantResponse.find(params[:id])

    respond_to do |format|
      if @applicant_response.update_attributes(params[:applicant_response])
        format.html { redirect_to @applicant_response, notice: 'Applicant response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @applicant_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicant_responses/1
  # DELETE /applicant_responses/1.json
  def destroy
    @applicant_response = ApplicantResponse.find(params[:id])
    @applicant_response.destroy

    respond_to do |format|
      format.html { redirect_to applicant_responses_url }
      format.json { head :no_content }
    end
  end
end
