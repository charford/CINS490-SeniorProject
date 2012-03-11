class AdministratorsController < ApplicationController
  before_filter :is_admin?
  
  # POST /administrators
  def create
    @administrator = Administrator.new(params[:administrator])

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to '/admin/permissions', notice: 'Administrator was successfully created.' }
      else
        format.html { redirect_to '/admin/permissions', notice: 'Error adding administrators.' }
      end
    end
  end

  # DELETE /administrators/1
   def destroy
    @administrator = Administrator.find(params[:id])
    if @administrator.user_id == current_user.id
      redirect_to '/admin/permissions', notice: 'You cannot delete yourself as an Administrator.'
      return
    end
    @administrator.destroy

    respond_to do |format|
      format.html { redirect_to '/admin/permissions', notice: 'Administrator destroyed.' }
    end
  end

  private

    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_to root_path, notice: 'You must be an administrator for this action.'
    end
end
