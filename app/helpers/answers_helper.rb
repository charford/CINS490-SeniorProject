module AnswersHelper
  def get_attachment_url applicant_id=params[:applicant_id], answer_id=params[:answer_id]
  	"/jobs/#{params[:job_id]}/applicants/#{applicant_id}/answers/#{answer_id}/get_attachment"
  	#/jobs/1-senior-project-director/applicants/3-new-new/answers/4/get_attachment
  end
  def show_attachment_url applicant_id, answer_id
  	"/jobs/#{params[:job_id]}/applicants/#{applicant_id}/answers/#{answer_id}/show_attachment"
  end
end
