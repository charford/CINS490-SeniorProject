module ApplicantsHelper
  ##NOT COMPLETE## => NEEDS TO BE FIXED, THE WHERE STATEMENT IS BROKEN
  def get_applicant_rating(applicant)
  	
    evaluator = Evaluator.find_by_user_id(current_user)
    evaluator.nil? ? evaluator = Administrator.find_by_user_id(current_user) : nil

    average = applicant.ratings.average('rating')
      rating_styles = ['','rate_1','rate_2','rate_3','rate_4','rate_5']
      !applicant.ratings.empty? ? "
      <div class='field' id='#{rating_styles[average.to_i]}'>
      <label>Average:</label>
        #{'%.2f' % average} / 5
      </div>
      <div class='field'>
        <label>Max:</label>
        #{applicant.ratings.order("rating").last.rating}
      </div>
      <div class='field'>
        <label>Min:</label>
        #{applicant.ratings.order("rating").first.rating}
      </div>
      <div class='field'>
        <label>Responses:</label>
        #{applicant.ratings.count}
      </div>
      <div id='clearfloats'></div>
      ".html_safe : "None"
    # end
  end

  def get_evaluator_rating(rating)
    rating_styles = ['','rate_1','rate_2','rate_3','rate_4','rate_5']
    rating_text = ['Unacceptable', 'Below Average', 'Acceptable', ]
    "
    <div class='rating' id='#{rating_styles[rating]}'>
      <label>Rated:</label>
      #{rating}
    </div>
    ".html_safe
  end

  def has_rated_applicant?(applicant)
    applicant.ratings.where("evaluator_id = ? and applicant_id = ?", current_user.id, applicant.id).empty? ? false : true
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
    case applicant.avgrating.to_i
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
  def show_reference_attachment_url applicant_id, reference_id
    "/jobs/#{params[:job_id]}/jobapps/#{params[:jobapp_id]}/applicants/#{applicant_id}/references/#{reference_id}/show_attachment"
  end
  def get_reference_attachment_url jobapp_id=params[:jobapp_id], applicant_id=params[:applicant_id], reference_id=params[:reference_id]
    "/jobs/#{params[:job_id]}/jobapps/#{jobapp_id}/applicants/#{applicant_id}/references/#{reference_id}/get_attachment"
  end
end
