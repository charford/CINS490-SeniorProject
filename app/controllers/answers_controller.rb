class AnswersController < ApplicationController

  def get_attachment
  @answer = Answer.find(params[:answer_id])
    filename = "resumes/#{@answer.id}/#{@answer.photo_file_name}"
    send_file filename, :filename => "#{@answer.id}.pdf",
            :type => "application/pdf",
            :disposition => "inline"
  end

  def show_attachment
    @job = Job.find(params[:job_id])
  end

  # # DELETE /answers/1
  # # DELETE /answers/1.json
  # def destroy
  #   @answer = Answer.find(params[:id])
  #   @answer.destroy

  #   respond_to do |format|
  #     format.html { redirect_to answers_url }
  #   end
  # end
end
