class PagesController < ApplicationController

  def index
    @user = User.new
    @submit_text = "Sign up"
  end

  def admin

  end

end
