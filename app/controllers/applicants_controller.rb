class ApplicantsController < ApplicationController
  before_filter :is_admin?, :except => [:index,:show,:new,:create,:update]
  # GET /applicants
  # GET /applicants.json
  def index
    @job = Job.find(params[:job_id])
    @applicants = @job.applicants

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /applicants/1
  # GET /applicants/1.json
  def show
    @applicant = Applicant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /applicants/new
  # GET /applicants/new.json
  def new
    @applicant = Applicant.new
    @job = Job.find(params[:job_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /applicants/1/edit
  def edit
    @applicant = Applicant.find(params[:id])
    @job = Job.find(params[:job_id])
  end

  # POST /applicants
  # POST /applicants.json
  def create
    @applicant = Applicant.new(params[:applicant])
    @job = Job.find(params[:job_id])

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to [@job,@applicant], notice: 'Applicant was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /applicants/1
  # PUT /applicants/1.json
  def update
    @applicant = Applicant.find(params[:id])

    respond_to do |format|
      if @applicant.update_attributes(params[:applicant])
        format.html { redirect_to [@job,@applicant], notice: 'Applicant was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /applicants/1
  # DELETE /applicants/1.json
  def destroy
    @applicant = Applicant.find(params[:id])
    @applicant.destroy

    respond_to do |format|
      format.html { redirect_to job_applicants_url }
    end
  end
  private
    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_to job_applicants_path, notice: 'You must be an administrator for this action.'
    end
end