module AdminHelper
  def link_to_destroy_rating rating
    @applicant = Applicant.find(rating.applicant_id)
    @job = Job.find(@applicant.job_id)
    link_to 'Destroy', job_jobapp_applicant_rating_path(@job,@job.jobapp,@applicant,rating),
      confirm: 'Are you sure?', method: :delete
  end

  def link_to_destroy_applicant applicant
    @job = Job.find(applicant.job_id)
    link_to 'Destroy', job_jobapp_applicant_path(@job,@job.jobapp,applicant),
      confirm: 'Are you sure?', method: :delete
  end

  def deactivate_user_path user_id
    "/users/#{user_id}/deactivate"
  end

  def activate_user_path user_id
    "/users/#{user_id}/activate"
  end

  def user_active? user_id
    return true if Activeuser.find_by_user_id(user_id)
    return false
  end
end
