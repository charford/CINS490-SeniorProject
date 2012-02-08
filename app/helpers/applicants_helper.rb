module ApplicantsHelper
  ##NOT COMPLETE## => NEEDS TO BE FIXED, THE WHERE STATEMENT IS BROKEN
  def get_applicant_rating
    @applicant = Applicant.find(params[:id])
    @evaluator = Evaluator.find_by_user_id(current_user.id)
    rating = 12
    if !@evaluator.nil?
      return rating if !Rating.where("evaluator_id = ? AND applicant_id = ?", @evaluator.id,@applicant.id).nil?
      return "You need to rate this applicant.#{@evaluator.id}"
    end
    return rating
  end
end
