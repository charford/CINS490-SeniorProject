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
    # @applicants = @job.applicants.where(" < ?", 18).order("avgrating DESC")
      @applicants = @job.applicants.order("avgrating DESC")
    
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
        format.html { redirect_to new_job_applicant_path(@job) }
      end
    end
  end

  # PUT /applicants/1
  # PUT /applicants/1.json
  def update
    @applicant = Applicant.find(params[:id])

    respond_to do |format|
      if @applicant.update_attributes(params[:applicant])
        #format.html { redirect_to [@job,@applicant], notice: 'Applicant was successfully updated.' }
        format.html { redirect_to User.find(@applicant.user_id), notice: 'Application was successfully updated.' }
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