class CommentsController < ApplicationController
  before_filter :is_admin?, :except => [:show,:new,:create,:update]
  before_filter :is_faculty?
  before_filter :get_job_and_applicant
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    params[:comment][:applicant_id] = @applicant.id
    params[:comment][:user_id] = current_user.id
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@job,@applicant], notice: 'Applicant comment was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
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

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to job_comments_url }
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