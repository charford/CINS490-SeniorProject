class JobsController < ApplicationController
  before_filter :validate_hiring_manager, :except => [:search,:show,:index]
  before_filter :validate_administrator, :except => [:create,:search,:show, :index, :update, :new, :edit]
  before_filter :validate_is_the_hiring_manager, :only => [:edit, :update]

  # GET /jobs
  def index
    @jobs = Job.search(params[:search]).where('published = ? ', true).paginate(:page => params[:page], :per_page => 5)
    @search = params[:search]
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /jobs/1
  def show
    @job = Job.find(params[:id])
    @tab = "overview"
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /jobs/new
  def new
    @job = Job.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /jobs/1/edit
  def edit
    @tab = "overview"
    @job = Job.find(params[:id])
  end

  # POST /jobs
  def create
    hiring_manager = HiringManager.find_by_user_id(current_user.id)
    hiring_manager.nil? ? hiring_manager = Administrator.find_by_user_id(current_user.id) : nil
    params[:job][:hiring_manager_id] = hiring_manager.user_id
    
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
      redirect_to jobs_path, :only_path => true, notice: 'You must be a hiring manager to post/edit a job.'
    end

    def validate_is_the_hiring_manager
      @job = Job.find(params[:id])
      return if Administrator.find_by_user_id(current_user)
      return if current_user.id == @job.hiring_manager_id
      redirect_to @job, :only_path => true, notice: 'You must be the hiring manager to edit this job.'
    end
end