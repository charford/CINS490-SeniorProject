class QuestionsController < ApplicationController
  before_filter :get_job_and_job_app

  # GET /questions
  # GET /questions.json
  def index
    #@questions = Question.all
    @questions = @job.jobapp.questions

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])
    @question.jobapp_id = @jobapp.id
    respond_to do |format|
      if @question.save
        format.html { redirect_to [@job,@jobapp,@question], :only_path => true, notice: 'Question was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to [@job,@question], :only_path => true, notice: 'Question was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    if !@question.jobapp.published
      @question.destroy
    end
    respond_to do |format|
      format.html { redirect_to edit_job_jobapp_path(@job,@job.jobapp), :only_path => true }
      format.js
    end
  end
  private
    def get_job_and_job_app
      @job = Job.find(params[:job_id])
      @jobapp = @job.jobapp
    end
end
