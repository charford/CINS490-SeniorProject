module UsersHelper
	def get_application_date(user,job_id)
		user.applicants.where("job_id = ?", job_id).map(&:created_at).first 
	end
end
