class UsersController < ApplicationController
  before_filter :is_admin?, :only => [:destroy,:deactivate,:activate]
  before_filter :authenticate, :except => [:new, :create]
  before_filter :correct_user

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
    @user = User.find(params[:id])
    @submit_text = "Save Changes"
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created.' }
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to '/admin/users', notice: 'User was destroyed.' }
    end
  end

  def activate
    user_id = params[:id]
    @activeuser = Activeuser.new
    @activeuser.user_id = user_id

    respond_to do |format|
      if @activeuser.save
        format.html { redirect_to '/admin/users', notice: 'User has been activated.' }
      else
        format.html { redirect_to '/admin/users', notice: 'Failed activating user. Is this user already active?' }
      end
    end
  end

  def deactivate
    user_id = params[:id]
    @activeuser = Activeuser.find_by_user_id(user_id)

    respond_to do |format|
      if @activeuser.destroy
        format.html { redirect_to '/admin/users', notice: 'User has been deactivated.' }
      else
        format.html { redirect_to '/admin/users', notice: 'Failed deactivating user.' }
      end
    end
  end
  
  private
  
    def correct_user
      return if Administrator.find_by_user_id(current_user)
      return if User.find_by_id(params[:id]) == current_user
      redirect_to root_path
    end

    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_back_or root_path, notice: 'You must be an Administrator to perform this task.'
    end
end