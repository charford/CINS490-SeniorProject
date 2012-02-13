module ApplicantsHelper
  ##NOT COMPLETE## => NEEDS TO BE FIXED, THE WHERE STATEMENT IS BROKEN
  def get_applicant_rating(applicant)
  	
    evaluator = Evaluator.find_by_user_id(current_user)
    evaluator.nil? ? evaluator = Administrator.find_by_user_id(current_user) : nil

    if applicant.ratings.where("evaluator_id = ?", evaluator.id).empty?
      render 'ratings/rate_applicant'
    else
      !applicant.ratings.empty? ? applicant.avgrating : "None"
    end
  end
  def get_attachment(answer_id)
  @answer = Answer.find(answer_id)
    filename = "resumes/#{@answer.id}/#{@answer.photo_file_name}"
    send_file filename, :filename => "#{@answer.id}.pdf",
            :type => "application/pdf",
            :disposition => "inline"
  end
end
