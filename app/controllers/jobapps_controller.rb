class JobappsController < ApplicationController
  before_filter :get_job
  before_filter :validate_is_the_hiring_manager, :only => [:edit, :update]

  def get_job
    @job = Job.find(params[:job_id])
  end

  def add_question
    question = @job.jobapp.questions.new
    question.job_id=@job.id
    question.qtype=params[:add_question]
    question.save
  end

  def remove_question
    Question.find(params[:remove_question]).destroy
  end

  # GET /jobapps
  def index
    @jobapps = Jobapp.all
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /jobapps/1
  def show
    @jobapp = Jobapp.find(params[:id])
    @tab = "application"
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /jobapps/1/edit
  def edit
    @jobapp = Jobapp.find(params[:id])
    @tab = "application"

    if params[:add_question]
      add_question
      respond_to do |format|
        format.html { redirect_to edit_job_jobapp_path(@job,@jobapp) }
      end
    end

    if params[:remove_question]
      remove_question 
      respond_to do |format|
        format.html { redirect_to edit_job_jobapp_path(@job,@jobapp) }
      end
    end
  end

  # # POST /jobapps
  # def create
  #   @jobapp = Jobapp.new(params[:jobapp])
  #   @jobapp.job_id = @job.id

  #   respond_to do |format|
  #     if @jobapp.save
  #       format.html { redirect_to job_path(@job), notice: 'Application was successfully created.' }
  #     else
  #       format.html { render action: "new" }
  #     end
  #   end
  # end

  # PUT /jobapps/1
  def update
    if !params[:add_question].nil?
      redirect_to root_path
      return
    end
    @jobapp = Jobapp.find(params[:id])
    respond_to do |format|
      if @jobapp.update_attributes(params[:jobapp])
        
        format.html { redirect_to edit_job_jobapp_path(@job,@jobapp), notice: 'Application was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /jobapps/1
  def destroy
    @jobapp = Jobapp.find(params[:id])
    @jobapp.destroy

    respond_to do |format|
      format.html { redirect_to job_jobapps_path(@job) }
    end
  end
  private
    def validate_is_the_hiring_manager
      @job = Job.find(params[:job_id])
      return if Administrator.find_by_user_id(current_user)
      return if current_user.id == @job.hiring_manager_id
      redirect_to [@job,@job.jobapp], :only_path => true, notice: 'You must be the hiring manager to edit this job application.'
    end
end
