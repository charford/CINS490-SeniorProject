class AdminController < ApplicationController
  before_filter :authenticate
  before_filter :is_admin?
  def index

  end

  def users
    @users = User.find(:all, :order => ("lastname,firstname"))
  end

  def confirmations
    @confirmations = Confirmation.all
  end

  def jobs
    @jobs = Job.find(:all, :order => ("position"))
  end

  def applicants
    @jobs = Job.all
    @applicants = Applicant.find(:all, :order => ("created_at DESC"))
    respond_to do |format|
      format.html
    end
  end

  def additional_facts
    @additional_facts = AdditionalFact.all
        
  end

  def reset_requests
    @requests = ResetRequest.all
  end

  def ratings
    @ratings = Rating.find(:all, :order => ("created_at DESC"))
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
      redirect_to root_path, :only_path => true
    end
end