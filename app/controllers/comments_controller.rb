class CommentsController < ApplicationController
  before_filter :is_admin?, :except => [:show,:new,:create,:update]
  before_filter :is_faculty?
  before_filter :get_job_and_applicant
  # GET /applicant_comments
  # GET /applicant_comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /applicant_comments/1
  # GET /applicant_comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /applicant_comments/new
  # GET /applicant_comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /applicant_comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /applicant_comments
  # POST /applicant_comments.json
  def create
    @comment = Comment.new(params[:applicant_comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Applicant comment was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /applicant_comments/1
  # PUT /applicant_comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:applicant_comment])
        format.html { redirect_to @comment, notice: 'Applicant comment was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /applicant_comments/1
  # DELETE /applicant_comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to applicant_comments_url }
    end
  end
  private
    def get_job_and_applicant
      @job = Job.find(params[:job_id])
      @applicant = Applicant.find(params[:applicant_id])
    end
    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_to root_path, notice: 'You do not have permission to perform this action.'
    end
    def is_faculty?
      return if Administrator.find_by_user_id(current_user)
      return if HiringManager.find_by_user_id(current_user)
      return if Evaluator.find_by_user_id(current_user)
      redirect_to root_path, notice: 'You do not have permission to perform this action.'
    end
end