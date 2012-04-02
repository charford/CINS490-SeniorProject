class AdminController < ApplicationController
  before_filter :authenticate
  before_filter :is_admin?

  def index
    @users = User.all
    @confirmations = Confirmation.all
    @applicants = Applicant.all
    @reset_requests = ResetRequest.all
    @administrators = Administrator.all
    @hiring_managers = HiringManager.all
    @evaluators = Evaluator.all
    @jobs = Job.all
    @additional_facts = AdditionalFact.all
    @ratings = Rating.all
    @server_uptime = %x[uptime | cut -d',' -f1]
    @server_load = %x[uptime | cut -d':' -f5]

  end

  def users
    @tab = "users"
    @users = User.order("firstname,lastname").paginate(:page => params[:page], :per_page => 10)
  end

  def confirmations
    @tab = "confirmations"
    @confirmations = Confirmation.all
  end

  def jobs
    @tab = "jobs"
    @jobs = Job.find(:all, :order => ("created_at DESC"))
  end

  def applicants
    @tab = "applicants"
    @jobs = Job.all
    @applicants = Applicant.find(:all, :order => ("created_at DESC"))
    respond_to do |format|
      format.html
    end
  end

  def additional_facts
    @tab = "additional_facts"
    @additional_facts = AdditionalFact.find(:all, :order => ("created_at DESC"))
        
  end

  def reset_requests
    @tab = "reset_requests"
    @requests = ResetRequest.all
  end

  def ratings
    @tab = "ratings"
    @ratings = Rating.find(:all, :order => ("created_at DESC"))
  end

  def permissions
    @tab = "permissions"
    @hiring_manager = HiringManager.new
    @hiringmanagers = HiringManager.paginate(:page => params[:hm_page], :per_page => 5)
  
    @administrator = Administrator.new
    @administrators = Administrator.paginate(:page => params[:admin_page], :per_page => 5)
  
    @evaluator = Evaluator.new
    @evaluators = Evaluator.paginate(:page => params[:eval_page], :per_page => 5)
  end

  private
    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_to root_path, :only_path => true
    end
end