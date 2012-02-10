module ApplicationHelper
  def check_for_debug
    return true if params[:debug].nil?
    return false if params[:debug] == false
  end

  def is_a_hiring_manager?
    HiringManager.find_by_user_id(current_user)
  end

  def is_an_administrator?
    Administrator.find_by_user_id(current_user)
  end

  def is_an_evaluator?
    Evaluator.find_by_user_id(current_user)
  end

  def is_faculty?
    return true if !HiringManager.find_by_user_id(current_user).nil?
    return true if !Administrator.find_by_user_id(current_user).nil?
    return true if !Evaluator.find_by_user_id(current_user).nil?
  end
end
