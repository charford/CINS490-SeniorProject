module UsersHelper
	def get_application_date(user,job_id)
		user.applicants.where("job_id = ?", job_id).map(&:created_at).first 
	end

  def get_application_date_updated(user,job_id)
    user.applicants.where("job_id = ?", job_id).map(&:updated_at).first 
  end

	def get_app_status(user_id,job_id)
    applicant = Applicant.where("user_id = ? and job_id = ? ", user_id, job_id).first
    updated_at = applicant.updated_at.strftime("%b %d, %Y")
    applicant.published? ? "Submitted on #{updated_at}" : "Saved, still needs to be submitted."
  end

  def link_to_edit_job_app(job)
    link_to job.position, edit_job_jobapp_applicant_path(job,job.jobapp,job.applicants.find_by_user_id(@user.id))
  end

  def show_link_to_new_user_reference(user)
    request.ssl? ? con_type = "https://" : con_type = "http://"
    link_to "#{con_type}#{request.env['HTTP_HOST']}/references/#{user.id}/#{user.reference_hash}", 
            "#{con_type}#{request.env['HTTP_HOST']}/references/#{user.id}/#{user.reference_hash}"
  end
  
  def user_job_apps_path(user)
    "#{user_path(user)}/jobapps"
  end

  def references_path(user)
    "#{user_path(user)}/references"
  end
end
