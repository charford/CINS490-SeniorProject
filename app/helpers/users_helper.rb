module UsersHelper
	def get_application_date(user,job_id)
		user.applicants.where("job_id = ?", job_id).map(&:created_at).first 
	end

	def get_app_status
    applicant = Applicant.find_by_user_id(@user.id)
    applicant.published? ? "Submitted" : "Saved, still needs to be submitted."
  end

  def link_to_edit_job_app(job)
    link_to job.position, edit_job_applicant_path(job,job.applicants.find_by_user_id(@user.id))
  end

  def show_link_to_new_user_reference(user)
    request.ssl? ? con_type = "https://" : con_type = "http://"
    link_to "#{con_type}#{request.env['HTTP_HOST']}/references/#{user.id}/#{user.reference_hash}", 
            "#{con_type}#{request.env['HTTP_HOST']}/references/#{user.id}/#{user.reference_hash}"
  end
end
