class ConfirmationsController < ApplicationController
  before_filter :is_admin?, :only => [:destroy]

  # DELETE /confirmations/1
  # DELETE /confirmations/1.json
  def destroy
    @confirmation = Confirmation.find(params[:id])
    @confirmation.destroy

    respond_to do |format|
      format.html { redirect_to confirmations_url, :only_path => true }
    end
  end
  private
    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_back_or root_path, :only_path => true, notice: 'You must be an Administrator to perform this task.'
    end
end
