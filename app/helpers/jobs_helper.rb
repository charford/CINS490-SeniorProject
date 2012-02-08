module JobsHelper
  def display_hiring_manager(hiring_manager_id)
    link_to User.find(HiringManager.find_by_id(hiring_manager_id).user_id), User.find(HiringManager.find_by_id(hiring_manager_id).user_id)
  end

  def is_a_hiring_manager?
	HiringManager.find_by_user_id(current_user)
  end
end
