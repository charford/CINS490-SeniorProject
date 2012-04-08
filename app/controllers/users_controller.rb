class UsersController < ApplicationController
  before_filter :is_admin?, :only => [:destroy,:deactivate,:activate]
  before_filter :authenticate, :except => [:new, :create, :confirm, :resetpw,:forgotpw]
  before_filter :correct_user, :except => [:confirm,:request_reference]

  def resetpw
    @request_hash = params[:request_hash]
    if request.post?
      reset_request = ResetRequest.find_by_request_hash(params[:request_hash])
      if reset_request.nil?
        redirect_to root_path
      else
        @user = User.find(reset_request.user_id)

        if @user.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation])
          ResetRequest.find_all_by_user_id(reset_request.user_id).each { |rs| rs.destroy }
          redirect_to login_path, :only_path => true, notice: "Your password has been reset."
        else
          redirect_to :back, :only_path => true, notice: "Failed to reset passwords. Password and password confirmation must match."
        end
      end
    end
  end

  def forgotpw
    if request.post?
      user = User.find_by_email(params[:email])
      if !user.nil?
        if UserMailer.reset_request(user).deliver
          redirect_to root_path, notice: "Sent link to reset password successfully."
        else
          redirect_to root_path, notice: "An error occurred."
        end  
      else
        redirect_to root_path, notice: "An error occurred."
      end
    end
  end

  def request_reference
    user = User.find(current_user.id)
    ref_email = params[:email]
    request.ssl? ? con_type = "https://" : con_type = "http://"
    UserMailer.request_reference(user,ref_email,request.host_with_port,con_type).deliver
    redirect_to :back, :only_path => true, notice: "Successfully sent reference request to #{ref_email}"
  end

  def confirm
    @user = User.find(params[:id])
    @confirm_hash = params[:confirm_hash]
    @confirmation = Confirmation.find_by_user_id(@user.id)
    if @confirmation.nil?
      redirect_to login_path, :only_path => true, notice: "Failed to activate account."
      return
    end
    if @confirmation.confirm_hash == @confirm_hash
      @activeuser = Activeuser.new
      @activeuser.user_id = @user.id
      if @activeuser.save
        @user.confirmation.destroy
        redirect_to login_path, :only_path => true, notice: "Successfully activated account. Please login to continue."
      else
        redirect_to login_path, :only_path => true, notice: "Failed to activate user. Please contact the system administrator."
      end
    else
      redirect_to login_path, :only_path => true, notice: "Failed to activate account."
    end
  end

  def jobapps
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end

  def references
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # GET /users/1
  def show
    @tab = "view"
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  def new
    @title = "Sign up"
    @user = User.new
    @submit_text = "Sign up"
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @tab = "edit"
    @user = User.find(params[:id])
    @submit_text = "Save Changes"
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        if @user.id == 1
          admin = Administrator.new
          admin.user_id = @user.id
          admin.save
        end
        UserMailer.welcome_email(@user).deliver
        format.html { redirect_to login_path, :only_path => true, notice: 'User was successfully created.' }
      else
        #format.html { render action: "new" }
        format.html { render action: "new" }
      end
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :only_path => true, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to '/admin/users', :only_path => true, notice: 'User was destroyed.' }
    end
  end

  def activate
    user_id = params[:id]
    @activeuser = Activeuser.new
    @activeuser.user_id = user_id

    respond_to do |format|
      if @activeuser.save
        format.html { redirect_to '/admin/users', :only_path => true, notice: 'User has been activated.' }
      else
        format.html { redirect_to '/admin/users', :only_path => true, notice: 'Failed activating user. Is this user already active?' }
      end
    end
  end

  def deactivate
    user_id = params[:id]
    @activeuser = Activeuser.find_by_user_id(user_id)

    if Administrator.find_by_user_id(user_id)
      redirect_to '/admin/users', :only_path => true, notice: 'Unable to deactive an administrator.'
      return
    end

    respond_to do |format|
      if @activeuser.destroy
        format.html { redirect_to '/admin/users', :only_path => true, notice: 'User has been deactivated.' }
      else
        format.html { redirect_to '/admin/users', :only_path => true, notice: 'Failed deactivating user.' }
      end
    end
  end
  
  private
  
    def correct_user
      return if Administrator.find_by_user_id(current_user)
      return if User.find_by_id(params[:id]) == current_user
      redirect_to root_path, :only_path => true
    end

    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_back_or root_path, :only_path => true, notice: 'You must be an Administrator to perform this task.'
    end
end