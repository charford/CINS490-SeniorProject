class EvaluatorsController < ApplicationController
  before_filter :is_admin?
 
  # POST /evaluators
  def create
    @evaluator = Evaluator.new(params[:evaluator])

    respond_to do |format|
      if @evaluator.save
        format.html { redirect_to '/admin/permissions', notice: 'Evaluator was successfully created.' }
      else
        format.html { redirect_to '/admin/permissions', notice: 'Error adding evaluator.' }
      end
    end
  end

  # DELETE /evaluators/1
  def destroy
    @evaluator = Evaluator.find(params[:id])
    @evaluator.destroy

    respond_to do |format|
      format.html { redirect_to '/admin/permissions', notice: 'Evaluator destroyed.' }
    end
  end

  private
    def is_admin?
      return if Administrator.find_by_user_id(current_user)
      redirect_to root_path, notice: 'You must be an administrator for this action.'
    end
end
