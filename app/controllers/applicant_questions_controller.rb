class ApplicantQuestionsController < ApplicationController
  # GET /applicant_questions
  # GET /applicant_questions.json
  def index
    @applicant_questions = ApplicantQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applicant_questions }
    end
  end

  # GET /applicant_questions/1
  # GET /applicant_questions/1.json
  def show
    @applicant_question = ApplicantQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @applicant_question }
    end
  end

  # GET /applicant_questions/new
  # GET /applicant_questions/new.json
  def new
    @applicant_question = ApplicantQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @applicant_question }
    end
  end

  # GET /applicant_questions/1/edit
  def edit
    @applicant_question = ApplicantQuestion.find(params[:id])
  end

  # POST /applicant_questions
  # POST /applicant_questions.json
  def create
    @applicant_question = ApplicantQuestion.new(params[:applicant_question])

    respond_to do |format|
      if @applicant_question.save
        format.html { redirect_to @applicant_question, notice: 'Applicant question was successfully created.' }
        format.json { render json: @applicant_question, status: :created, location: @applicant_question }
      else
        format.html { render action: "new" }
        format.json { render json: @applicant_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /applicant_questions/1
  # PUT /applicant_questions/1.json
  def update
    @applicant_question = ApplicantQuestion.find(params[:id])

    respond_to do |format|
      if @applicant_question.update_attributes(params[:applicant_question])
        format.html { redirect_to @applicant_question, notice: 'Applicant question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @applicant_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicant_questions/1
  # DELETE /applicant_questions/1.json
  def destroy
    @applicant_question = ApplicantQuestion.find(params[:id])
    @applicant_question.destroy

    respond_to do |format|
      format.html { redirect_to applicant_questions_url }
      format.json { head :no_content }
    end
  end
end
