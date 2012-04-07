class AnswersController < ApplicationController
  before_filter :is_faculty?
  def get_attachment
  @answer = Answer.find(sanitize_filename(params[:answer_id]))
    #filename = "resumes/#{sanitize_filename @answer.id}/#{sanitize_filename @answer.photo_file_name}"
    filename = sanitize_filename(@answer.photo_file_name)
    path = "resumes/#{@answer.id}/#{filename}"
    send_file path, :filename => sanitize_filename("#{@answer.id}.pdf"),
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
  def sanitize_filename(filename)
  filename.gsub(/[^0-9A-z.\-]/, '_')
  end

  private 
    def is_faculty?
      return if Administrator.find_by_user_id(current_user)
      return if Evaluator.find_by_user_id(current_user)
      return if HiringManager.find_by_user_id(current_user)
      redirect_to root_path
    end
end


