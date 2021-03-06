module JobsHelper
  def display_hiring_manager(hiring_manager_id)
  	hiring_manager = HiringManager.find_by_id(hiring_manager_id)
  	hiring_manager.nil? ? hiring_manager = Administrator.find_by_id(hiring_manager_id) : nil
    link_to User.find(hiring_manager.user_id), User.find(hiring_manager.user_id)
  end

  def is_a_hiring_manager?
    return true if !Administrator.find_by_user_id(current_user).nil?
	  return true if !HiringManager.find_by_user_id(current_user).nil?
	  return false
  end

  def is_the_hiring_manager? job
    return true if Administrator.find_by_user_id(current_user)
    return false if HiringManager.find_by_user_id(current_user).nil?
    return true if HiringManager.find_by_user_id(current_user).user_id == job.hiring_manager_id
  end

  def link_to_view_applicants(job)
    link_to content_tag(:span,"View Applicants(#{job.applicants.where('published = ?', true).count})"), job_jobapp_applicants_path(job,job.jobapp)
  end
end
