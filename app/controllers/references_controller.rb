class ReferencesController < ApplicationController
  before_filter :is_correct_user_and_hash?
  # GET /references
  def index
    @references = Reference.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /references/1
  def show
    @reference = Reference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /references/new
  def new
    @reference = Reference.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /references/1/edit
  def edit
    @reference = Reference.find(params[:id])
  end

  # POST /references
  def create
    @reference = Reference.new(params[:reference])
    return if !verify_hash_is_valid
    respond_to do |format|
      if @reference.save
        format.html { redirect_to @reference, notice: 'Reference was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /references/1
  def update
    @reference = Reference.find(params[:id])

    respond_to do |format|
      if @reference.update_attributes(params[:reference])
        format.html { redirect_to @reference, notice: 'Reference was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /references/1
  def destroy
    @reference = Reference.find(params[:id])
    @reference.destroy

    respond_to do |format|
      format.html { redirect_to references_url }
    end
  end
    private
    def verify_hash_is_valid
      User.find(@reference.user_id).reference_hash == @reference.reference_hash ? true : false
    end

    def is_correct_user_and_hash?
      if User.where("id = ? AND reference_hash = ?", params[:user_id], params[:reference_hash]).empty?
        redirect_to root_path
      end
    end
end
