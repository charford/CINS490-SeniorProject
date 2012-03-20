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

  def link_to_job_application
    @job = Job.find(params[:id])
    if @job.jobapp.nil?
      link_to "New Application", new_job_jobapp_path(@job)
    else
      link_to "Edit Application", edit_job_jobapp_path(@job,@job.jobapp)
    end
  end

  def is_current_job_page? tab
    return "current_page_tab" if tab == 'Overview' and params[:controller] = 'jobs' and params[:action] == 'show'
    return "current_page_tab" if tab == 'Applicants' and params[:controller] == 'jobs' and params[:action] == 'index'
    return "current_page_tab" if tab == 'Application' and params[:controller] == 'jobapps'
    return "current_page_tab" if tab == 'Apply' and params[:controller] == 'applicants' and params[:action] == 'new'
  end

  #########################################################################
  # THIS CODE WAS NOT WRITTEN ENTIRELY BY ME. I RECIEVED THIS CODE        #
  # FROM TYSON HENRY's PROJECT FOR "GROUPS" IT HAS BEEN MODIFIED.         # => TODO REMOVE thiS, i'm not using it
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
