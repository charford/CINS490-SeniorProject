class AdditionalFactsController < ApplicationController
  # GET /additional_facts
  def index
    @additional_facts = AdditionalFact.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /additional_facts/1
  def show
    @additional_fact = AdditionalFact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /additional_facts/new
  def new
    @additional_fact = AdditionalFact.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /additional_facts/1/edit
  def edit
    @additional_fact = AdditionalFact.find(params[:id])
  end

  # POST /additional_facts
  def create
    @job = Job.find(params[:job_id])
    params[:additional_fact][:applicant_id] = params[:applicant_id]
    @applicant = Applicant.find(params[:applicant_id])
    evaluator = Evaluator.find_by_user_id(current_user)
    evaluator.nil? ? evaluator = Administrator.find_by_user_id(current_user) : nil
    params[:additional_fact][:evaluator_id] = User.find(evaluator.user_id).id
    @additional_fact = AdditionalFact.new(params[:additional_fact])

    respond_to do |format|
      if @additional_fact.save
        format.html { redirect_to [@job,@job.jobapp,@applicant], notice: 'Additional fact was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /additional_facts/1
  def update
    @additional_fact = AdditionalFact.find(params[:id])

    respond_to do |format|
      if @additional_fact.update_attributes(params[:additional_fact])
        format.html { redirect_to @additional_fact, notice: 'Additional fact was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /additional_facts/1
  def destroy
    @additional_fact = AdditionalFact.find(params[:id])
    @additional_fact.destroy

    respond_to do |format|
      format.html { redirect_to additional_facts_url }
    end
  end
end
