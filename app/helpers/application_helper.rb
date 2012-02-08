module ApplicationHelper
  def check_for_debug
    return true if params[:debug].nil?
    return false if params[:debug] == false
  end
end
