class HiringManagersController < ApplicationController
  before_filter :is_admin?

  # POST /hiring_managers
  # POST /hiring_managers.json
  def create
    @hiring_manager = HiringManager.new(params[:hiring_manager])

    respond_to do |format|
      if @hiring_manager.save
        format.html { redirect_to '/admin/permissions', notice: 'Hiring manager was successfully created.' }
      else
        format.html { redirect_to '/admin/permissions', notice: 'Error adding hiring manager.' }
      end
    end
  end

  # DELETE /hiring_managers/1
  # DELETE /hiring_managers/1.json
  def destroy
    @hiring_manager = HiringManager.find(params[:id])
    @hiring_manager.destroy

    respond_to do |format|
      format.html { redirect_to '/admin/permissions', notice: 'Hiring manager destroyed.' }
    end
  end

  private

    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_to root_path, notice: 'You must be an administrator for this action.'
    end
end
