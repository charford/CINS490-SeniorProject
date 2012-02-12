class JobsController < ApplicationController
  before_filter :validate_administrator, :except => [:show, :index, :update, :new]
  before_filter :validate_hiring_manager, :except => [:show, :index]
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    hiring_manager = HiringManager.find_by_user_id(current_user.id)
    hiring_manager.nil? ? hiring_manager = Administrator.find_by_user_id(current_user.id) : nil
    params[:job][:hiring_manager_id] = hiring_manager.id
    
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
    end
  end

  private

    def validate_administrator
      return if Administrator.find_by_user_id(current_user)
      redirect_to jobs_path, notice: 'You must be an Administrator to perform this task.'
    end

    def validate_hiring_manager
      return if Administrator.find_by_user_id(current_user)
      return if HiringManager.find_by_user_id(current_user)
      redirect_to jobs_path, notice: 'You must be a hiring manager to post a job.'
    end
end