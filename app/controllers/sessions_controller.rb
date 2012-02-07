class SessionsController < ApplicationController
  def new 
    @title = "Login"
    redirect_to current_user if signed_in?
  end 
  
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password]);
    if user.nil?
      @title = "Login"
      redirect_to login_path, :notice =>  "Grabatar was unable to authenticate, please try again."
    else
      sign_in user
      redirect_to root_path, :notice => "Created Account Successfully!"
    end 
  end 
  
  def destroy
    clear_return_to
    sign_out
    redirect_to root_path
  end 
end
