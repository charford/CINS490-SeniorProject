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

  #########################################################################
  # THIS CODE WAS NOT WRITTEN ENTIRELY BY ME. I RECIEVED THIS CODE        #
  # FROM TYSON HENRY's PROJECT FOR "GROUPS" IT HAS BEEN MODIFIED.         #
  #                                                                      ###
  # create a link that allows user to create a new object                 #
  # from railscasts 197
  # name: the link’s text
  # f: the form builder object
  # association: the class associated with this new link (e.g., “questions” or “elements”)

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
