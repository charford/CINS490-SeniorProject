class QuestionsController < ApplicationController
  before_filter :get_job_and_job_app

  # DELETE /questions/1
  def destroy
    @question = Question.find(params[:id])
    if !@question.jobapp.published
      @question.destroy
    end
    respond_to do |format|
      format.html { redirect_to edit_job_jobapp_path(@job,@job.jobapp), :only_path => true }
      format.js
    end
  end

  private
    def get_job_and_job_app
      @job = Job.find(params[:job_id])
      @jobapp = @job.jobapp
    end
end
