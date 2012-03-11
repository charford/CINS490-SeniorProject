class RatingsController < ApplicationController
  before_filter :get_job_and_applicant
  
  # GET /ratings
  def index
    @ratings = @applicant.ratings

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # POST /ratings
  def create
    params[:rating][:applicant_id] = params[:applicant_id]
    evaluator = Evaluator.find_by_user_id(current_user)
    evaluator.nil? ? evaluator = Administrator.find_by_user_id(current_user) : nil
    params[:rating][:evaluator_id] = evaluator.user_id

    @rating = Rating.new(params[:rating])

    respond_to do |format|
      if @rating.save
        applicant = Applicant.find(@rating.applicant_id)
        applicant.update_attribute(:avgrating, applicant.ratings.average('rating'))
        format.html { redirect_to [@job,@job.jobapp,@applicant], notice: 'Rating was successfully created.' }
      else
        format.html { redirect_to [@job,@job.jobapp,@applicant], notice: 'An error occurred while rating applicant.' }
      end
    end
  end

  # DELETE /ratings/1
  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to '/admin/ratings', notice: 'Destroyed rating.' }
    end
  end

  private

    def get_job_and_applicant
      @job = Job.find(params[:job_id])
      @applicant = Applicant.find(params[:applicant_id])
    end
end
