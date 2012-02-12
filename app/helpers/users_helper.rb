module UsersHelper
	def get_application_date(user,job_id)
		user.applicants.where("job_id = ?", job_id).map(&:created_at).first 
	end

	def get_app_status
    applicant = Applicant.find_by_user_id(@user.id)
    applicant.published? ? "Submitted" : "Saved, still needs to be submitted."
  end
end
