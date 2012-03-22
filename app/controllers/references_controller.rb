class ReferencesController < ApplicationController
 # before_filter :is_correct_user_and_hash?, :except => [:index, :destroy]
  #before_filter :correct_user, :except => [:new, :create]

  # GET /references
  def index
    @user = User.find(params[:user_id])
    @references = @user.references

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

  # POST /references
  def create
    @reference = Reference.new(params[:reference])
    return if !verify_hash_is_valid
    respond_to do |format|
      if @reference.save
        format.html { redirect_to root_path, notice: 'Reference was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def request_reference
    
  end

  # DELETE /references/1
  def destroy
    @reference = Reference.find(params[:id])
    @reference.destroy
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html { redirect_to user_references_url(@user) }
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

    def correct_user
      return if Administrator.find_by_user_id(current_user)
      return if User.find_by_id(params[:user_id]) == current_user
      redirect_to root_path
    end
end
