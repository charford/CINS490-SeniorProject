class AdditionalFactsController < ApplicationController
  # GET /additional_facts
  # GET /additional_facts.json
  def index
    @additional_facts = AdditionalFact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @additional_facts }
    end
  end

  # GET /additional_facts/1
  # GET /additional_facts/1.json
  def show
    @additional_fact = AdditionalFact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @additional_fact }
    end
  end

  # GET /additional_facts/new
  # GET /additional_facts/new.json
  def new
    @additional_fact = AdditionalFact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @additional_fact }
    end
  end

  # GET /additional_facts/1/edit
  def edit
    @additional_fact = AdditionalFact.find(params[:id])
  end

  # POST /additional_facts
  # POST /additional_facts.json
  def create
    @additional_fact = AdditionalFact.new(params[:additional_fact])

    respond_to do |format|
      if @additional_fact.save
        format.html { redirect_to @additional_fact, notice: 'Additional fact was successfully created.' }
        format.json { render json: @additional_fact, status: :created, location: @additional_fact }
      else
        format.html { render action: "new" }
        format.json { render json: @additional_fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /additional_facts/1
  # PUT /additional_facts/1.json
  def update
    @additional_fact = AdditionalFact.find(params[:id])

    respond_to do |format|
      if @additional_fact.update_attributes(params[:additional_fact])
        format.html { redirect_to @additional_fact, notice: 'Additional fact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @additional_fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /additional_facts/1
  # DELETE /additional_facts/1.json
  def destroy
    @additional_fact = AdditionalFact.find(params[:id])
    @additional_fact.destroy

    respond_to do |format|
      format.html { redirect_to additional_facts_url }
      format.json { head :no_content }
    end
  end
end
