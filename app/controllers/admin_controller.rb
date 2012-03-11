class AdminController < ApplicationController
  before_filter :authenticate
  before_filter :is_admin?
  def index

  end

  def users
    @users = User.find(:all, :order => ("lastname,firstname"))
    respond_to do |format|
      format.html
    end
  end

  private
    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_to root_path
    end
end
