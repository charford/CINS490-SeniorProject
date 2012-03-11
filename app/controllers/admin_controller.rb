class AdminController < ApplicationController
  before_filter :authenticate
  before_filter :is_admin?
  def index

  end

  def users
    @users = User.find(:all, :order => ("lastname,firstname"))
    respond_to do |format|
      format.html
    end
  end

  def jobs
    @jobs = Job.find(:all, :order => ("position"))
    respond_to do |format|
      format.html
    end
  end

  def applicants
    @jobs = Job.all
    @applicants = Applicant.find(:all, :order => ("created_at DESC"))
    respond_to do |format|
      format.html
    end
  end

  def ratings
    @ratings = Rating.find(:all, :order => ("created_at DESC"))
    respond_to do |format|
      format.html
    end
  end

  def permissions
    @hiring_manager = HiringManager.new
    @hiringmanagers = HiringManager.all
  
    @administrator = Administrator.new
    @administrators = Administrator.all
  
    @evaluator = Evaluator.new
    @evaluators = Evaluator.all
  end

  private
    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_to root_path
    end
end
