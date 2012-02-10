module ApplicantsHelper
  ##NOT COMPLETE## => NEEDS TO BE FIXED, THE WHERE STATEMENT IS BROKEN
  def get_applicant_rating(applicant)
    evaluator = Evaluator.find_by_user_id(current_user)
    if applicant.ratings.where("evaluator_id = ?", evaluator.id).empty?
      render 'ratings/rate_applicant'
    else
      !applicant.ratings.empty? ? sprintf("%.2f",applicant.ratings.average('rating')) : "None"
    end
  end
end
