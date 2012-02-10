class RatingsController < ApplicationController
  before_filter :get_job_and_applicant
  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = @applicant.ratings

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
    @rating = Rating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /ratings/new
  # GET /ratings/new.json
  def new
    @rating = Rating.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /ratings/1/edit
  def edit
    @rating = Rating.find(params[:id])
  end

  # POST /ratings
  # POST /ratings.json
  def create
    params[:rating][:applicant_id] = params[:applicant_id]
    params[:rating][:evaluator_id] = Evaluator.find_by_user_id(current_user).id

    @rating = Rating.new(params[:rating])

    respond_to do |format|
      if @rating.save
        format.html { redirect_to [@job,@applicant], notice: 'Rating was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.json
  def update
    @rating = Rating.find(params[:id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to job_applicant_ratings_url(@job,@applicant) }
    end
  end

  private

    def get_job_and_applicant
      @job = Job.find(params[:job_id])
      @applicant = Applicant.find(params[:applicant_id])
    end
end
