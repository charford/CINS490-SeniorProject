class ApplicantsController < ApplicationController
  before_filter :is_admin?, :except => [:index,:show,:new,:create,:update,:edit]
  before_filter :is_faculty?, :except => [:new, :create,:edit,:update]
  before_filter :is_signed_in?
  before_filter :get_job
  before_filter :is_the_applicant?, :only => [:edit,:update]
  
  def resume
    @applicant = Applicant.find(params[:applicant_id])
  end

  def get_job
    @job = Job.find(params[:job_id])
  end
  # GET /applicants
  # GET /applicants.json
  def index
    if Administrator.find_by_user_id(current_user)
      @evaluator_id = Administrator.find_by_user_id(current_user).user_id
    else
      @evaluator_id = Evaluator.find_by_user_id(current_user).user_id
    end
    @applicants = 
      @job.applicants.where("published = ? 
                            AND id IN (SELECT applicant_id FROM ratings WHERE evaluator_id = ?)",
                            true,@evaluator_id).order("avgrating DESC")
    @unrated_applicants = 
      @job.applicants.where("published = ? 
                            AND id NOT IN (SELECT applicant_id FROM ratings WHERE evaluator_id = ?)",
                            true,@evaluator_id)
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /applicants/1
  # GET /applicants/1.json
  def show
    @applicant = Applicant.find(params[:id])
    @job = Job.find(params[:job_id])
    @rating = Rating.new
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /applicants/new
  # GET /applicants/new.json
  def new
    @applicant = Applicant.new
    @job = Job.find(params[:job_id])
    @job.jobapp.questions.each do |question|
      answer = @applicant.answers.build
      answer.question_id = question.id
    end

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
    @job = Job.find(params[:job_id])
   
    @applicant = Applicant.new(params[:applicant])
    @applicant.job_id = @job.id
    @applicant.user_id = current_user.id

    respond_to do |format|
      if @applicant.save
        #format.html { redirect_to new_job_applicant_answers_path(@job,@applicant), notice: 'Applicant was successfully created.' }
        format.html { redirect_to User.find(@applicant.user_id), notice: 'Application was successfully created.' }
      else
        #format.html { render action: "new" }
        format.html { redirect_to new_job_jobapp_applicant_path(@job,@job.jobapp) }
      end
    end
  end

  # PUT /applicants/1
  # PUT /applicants/1.json
  def update
    @applicant = Applicant.find(params[:id])
    @job = Job.find(params[:job_id])
    if @applicant.published?
      redirect_to edit_job_jobapp_applicant_path(@job,@job.jobapp,@applicant), 
        notice: 'This application has already been submitted. Changes cannot be made at this time.'
      return
    end

    respond_to do |format|
      if @applicant.update_attributes(params[:applicant])
        #format.html { redirect_to [@job,@applicant], notice: 'Applicant was successfully updated.' }
        #format.html { redirect_to user_jobapps_path(@applicant.user_id), notice: 'Application was successfully updated.' }
        format.html { redirect_to user_job_apps_path(User.find(@applicant.user_id)), notice: 'Application was successfully updated.' }
      else
        format.html { redirect_to edit_job_jobapp_applicant_path(@job,@job.jobapp) }
      end
    end
  end

  # DELETE /applicants/1
  # DELETE /applicants/1.json
  def destroy
    @applicant = Applicant.find(params[:id])
    @applicant.destroy
    @job = Job.find(params[:job_id])
    respond_to do |format|
      format.html { redirect_to '/admin/applicants', notice: 'Successfully deleted applicant.' }
    end
  end
  private
    
    def user_job_apps_path(user)
    "#{user_path(user)}/jobapps"
    end
    
    def is_admin?
      @job = Job.find(params[:job_id])
      return if Administrator.find_by_user_id(current_user)
      redirect_to job_jobapp_applicants_path(@job,@job.jobapp), notice: 'You must be an administrator for this action.'
    end

    def is_faculty?
      return if Administrator.find_by_user_id(current_user)
      return if Evaluator.find_by_user_id(current_user)
      return if HiringManager.find_by_user_id(current_user)
      redirect_to root_path
    end

    def is_signed_in?
      return if signed_in?
      job=Job.find(params[:job_id])
      redirect_to job, notice: 'You must create an account before applying for a job.'
    end

    # def is_the_hiring_manager?
    #   return true if Administrator.find_by_user_id(current_user)

    #   job = Job.find(params[:job_id])
    #   hiringmanager = HiringManager.find(job.hiring_manager_id)
    #   if hiringmanager.user_id == current_user.id
    #     return true
    #   else
    #     return false
    #   end
    # end

    def is_the_applicant?
      return if Administrator.find_by_user_id(current_user)
      if params[:applicant_id].nil? 
        applicant = Applicant.find(params[:id])
      else
        applicant = Applicant.find(params[:applicant_id])
      end
      return if applicant.user_id == current_user.id
      redirect_to root_path
    end
end