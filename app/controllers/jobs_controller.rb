class JobsController < ApplicationController
  before_filter :validate_hiring_manager, :except => [:search,:show,:index]
  before_filter :validate_administrator, :except => [:create,:search,:show, :index, :update, :new, :edit]
  before_filter :validate_is_the_hiring_manager, :only => [:edit, :update]
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.search(params[:search]).paginate(:page => params[:page], :per_page => 5)

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
    hiring_manager = HiringManager.find_by_user_id(current_user.id).user_id
    hiring_manager.nil? ? hiring_manager = Administrator.find_by_user_id(current_user.id).user_id : nil
    params[:job][:hiring_manager_id] = hiring_manager
    
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        @jobapp = Jobapp.new
        @jobapp.job_id = @job.id
        @jobapp.save
        format.html { redirect_to @job, :only_path => true, notice: 'Job was successfully created.' }
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
        format.html { redirect_to @job, :only_path => true, notice: 'Job was successfully updated.' }
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
      format.html { redirect_to '/admin/jobs', :only_path => true, notice: 'Job destroyed.' }
    end
  end

  private

    def validate_administrator
      return if Administrator.find_by_user_id(current_user)
      redirect_to jobs_path, :only_path => true, notice: 'You must be an Administrator to perform this task.'
    end

    def validate_hiring_manager
      return if Administrator.find_by_user_id(current_user)
      return if HiringManager.find_by_user_id(current_user)
      redirect_to Job.find(params[:id]), :only_path => true, notice: 'You must be a hiring manager to post/edit a job.'
    end

    def validate_is_the_hiring_manager
      @job = Job.find(params[:id])
      return if Administrator.find_by_user_id(current_user)
      return if current_user.id == @job.hiring_manager_id
      redirect_to @job, :only_path => true, notice: 'You must be the hiring manager to edit this job.'
    end
end