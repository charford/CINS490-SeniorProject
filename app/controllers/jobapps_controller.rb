class JobappsController < ApplicationController
  before_filter :get_job
  before_filter :is_hiring_manager?, :except => [:show]

  def add_question
    #jobapp = Jobapp.find(params[:jobapp_id])
    question = @job.jobapp.questions.new
    question.job_id=@job.id
    question.qtype=params[:add_question]
    
    question.save
  end

  def remove_question
    Question.find(params[:remove_question]).destroy
  end

  def get_job
    @job = Job.find(params[:job_id])
  end
  # GET /jobapps
  # GET /jobapps.json
  def index
    @jobapps = Jobapp.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobapps }
    end
  end

  # GET /jobapps/1
  # GET /jobapps/1.json
  def show
    @jobapp = Jobapp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jobapp }
    end
  end

  # GET /jobapps/new
  # GET /jobapps/new.json
  def new
    @jobapp = Jobapp.new
    2.times { questions = @jobapp.questions.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jobapp }
    end
  end

  # GET /jobapps/1/edit
  def edit
    @jobapp = Jobapp.find(params[:id])

    if params[:add_question]
      add_question
      respond_to do |format|
        format.html { redirect_to edit_job_jobapp_path(@job,@jobapp) }
        format.js
      end
    end

    if params[:remove_question]
      remove_question 
      respond_to do |format|
        format.html { redirect_to edit_job_jobapp_path(@job,@jobapp) }
        format.js
      end
    end
  end

  # POST /jobapps
  # POST /jobapps.json
  def create
    @jobapp = Jobapp.new(params[:jobapp])
    @jobapp.job_id = @job.id

    respond_to do |format|
      if @jobapp.save
        format.html { redirect_to job_path(@job), notice: 'Jobapp was successfully created.' }
        format.json { render json: @jobapp, status: :created, location: @jobapp }
      else
        format.html { render action: "new" }
        format.json { render json: @jobapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobapps/1
  # PUT /jobapps/1.json
  def update
    @jobapp = Jobapp.find(params[:id])
    respond_to do |format|
      if @jobapp.update_attributes(params[:jobapp])
        format.html { redirect_to job_jobapp_path(@job,@jobapp), notice: 'Jobapp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jobapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobapps/1
  # DELETE /jobapps/1.json
  def destroy
    @jobapp = Jobapp.find(params[:id])
    @jobapp.destroy

    respond_to do |format|
      format.html { redirect_to job_jobapps_path(@job) }
      format.json { head :no_content }
    end
  end
  private
    def is_hiring_manager?
      return if Administrator.find_by_user_id(current_user)
      return if HiringManager.find_by_user_id(current_user)
      redirect_to job_jobapp_path(@job,@job.jobapp), notice: 'You must be a hiring manager to edit a job application.'
    end
end
