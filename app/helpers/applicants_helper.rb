module ApplicantsHelper
  ##NOT COMPLETE## => NEEDS TO BE FIXED, THE WHERE STATEMENT IS BROKEN
  def get_applicant_rating(applicant)
  	
    evaluator = Evaluator.find_by_user_id(current_user)
    evaluator.nil? ? evaluator = Administrator.find_by_user_id(current_user) : nil

    if applicant.ratings.where("evaluator_id = ?", evaluator.user_id).empty?
      render 'ratings/rate_applicant'
    else
      !applicant.ratings.empty? ? "#{applicant.avgrating} / 5" : "None"
    end
  end

  def has_rated_applicant?(applicant)
    evaluator = Evaluator.find_by_user_id(current_user)
    evaluator.nil? ? evaluator = Administrator.find_by_user_id(current_user) : nil
    return false if evaluator.nil?
    if applicant.ratings.where("evaluator_id = ?", evaluator.id).nil?
      return false
    else
      return true
    end
  end

  def get_attachment(answer_id)
  @answer = Answer.find(answer_id)
    filename = "resumes/#{@answer.id}/#{@answer.photo_file_name}"
    send_file filename, :filename => "#{@answer.id}.doc",
            :type => "application/doc",
  end

  def new_applicant
    @job = Job.find(params[:job_id])
    @job.applicants.find_by_user_id(current_user.id).nil? ? true : false
  end

  def set_row_color(applicant)
    case applicant.avgrating
      when 1
        "<tr class=\"rating_1_row\">"
      when 2
        "<tr class=\"rating_2_row\">"
      when 3
        "<tr class=\"rating_3_row\">"
      when 4
        "<tr class=\"rating_4_row\">"
      when 5
        "<tr class=\"rating_5_row\">"
      else
        "<tr>"
    end
  end

  def get_total_comments(applicants)
  total=0
    applicants.each do |applicant|
      total+=applicant.comments.count
    end
    "#{total}"
  end

  def get_total_ratings(applicants)
  total=0
    applicants.each do |applicant|
      total+=applicant.ratings.count
    end
    "#{total}"
  end
end
