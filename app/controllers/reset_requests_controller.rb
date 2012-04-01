class ResetRequestsController < ApplicationController
  before_filter :is_admin?, :only => [:destroy,:deactivate,:activate]
  # DELETE /reset_requests/1
  def destroy
    @reset_request = ResetRequest.find(params[:id])
    @reset_request.destroy

    respond_to do |format|
      format.html { redirect_to '/admin/reset_requests', :only_path => true }
    end
  end
  private
    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_back_or root_path, :only_path => true, notice: 'You must be an Administrator to perform this task.'
    end
end
