class EvaluatorsController < ApplicationController
  before_filter :is_admin?
  # GET /evaluators
  # GET /evaluators.json
  def index
    @evaluators = Evaluator.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /evaluators/1
  # GET /evaluators/1.json
  def show
    @evaluator = Evaluator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /evaluators/new
  # GET /evaluators/new.json
  def new
    @evaluator = Evaluator.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /evaluators/1/edit
  def edit
    @evaluator = Evaluator.find(params[:id])
  end

  # POST /evaluators
  # POST /evaluators.json
  def create
    @evaluator = Evaluator.new(params[:evaluator])

    respond_to do |format|
      if @evaluator.save
        format.html { redirect_to @evaluator, notice: 'Evaluator was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /evaluators/1
  # PUT /evaluators/1.json
  def update
    @evaluator = Evaluator.find(params[:id])

    respond_to do |format|
      if @evaluator.update_attributes(params[:evaluator])
        format.html { redirect_to @evaluator, notice: 'Evaluator was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /evaluators/1
  # DELETE /evaluators/1.json
  def destroy
    @evaluator = Evaluator.find(params[:id])
    @evaluator.destroy

    respond_to do |format|
      format.html { redirect_to evaluators_url }
    end
  end
  private
  def is_admin?
    return if Administrator.find_by_user_id(current_user)
    redirect_to root_path, notice: 'You must be an administrator for this action.'
  end
end
