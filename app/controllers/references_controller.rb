class ReferencesController < ApplicationController
  before_filter :is_correct_user_and_hash?, :only => [:new]
  before_filter :verify_hash_is_valid, :only => [:create]
  before_filter :is_faculty?, :except => [:new,:create]
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
    if !verify_hash_is_valid
      redirect_to root_path
      return
    end
    respond_to do |format|
      if @reference.save
        format.html { redirect_to root_path, :only_path => true, notice: 'Reference was successfully created.' }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def show_attachment
    @job = Job.find(params[:job_id])
  end
  
  def get_attachment
    @reference = Reference.find(params[:reference_id])
    filename = @reference.photo_file_name
    path = "references/#{@reference.id}/#{@reference.photo_file_name}"
    send_file path, :filename => filename,
            :type => "application/pdf",
            :disposition => "attached"
  end

  # DELETE /references/1
  def destroy
    @reference = Reference.find(params[:id])
    @reference.destroy
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html { redirect_to user_references_url(@user), :only_path => true }
    end
  end
    private
    def verify_hash_is_valid
      user = User.find(params[:reference][:user_id])
      if user.nil?
        redirect_to root_path
        return
      end
      user.reference_hash == params[:reference][:reference_hash] ? true : false
    end

    def is_correct_user_and_hash?
      if User.where("id = ? AND reference_hash = ?", params[:user_id], params[:reference_hash]).empty?
        redirect_to root_path, :only_path => true
      end
    end

    def correct_user
      return if Administrator.find_by_user_id(current_user)
      return if User.find_by_id(params[:user_id]) == current_user
      redirect_to root_path, :only_path => true
    end

    def sanitize_filename(filename)
      filename.gsub(/[^0-9A-z.\-]/, '_')
    end
    def is_faculty?
      return if Administrator.find_by_user_id(current_user)
      return if Evaluator.find_by_user_id(current_user)
      return if HiringManager.find_by_user_id(current_user)
      redirect_to root_path
    end
end
