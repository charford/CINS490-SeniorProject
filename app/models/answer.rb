class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :applicant
  has_attached_file :photo, :path => "resumes/:id/:basename.:extension"
  attr_accessible :question_id, :applicant_id, :body, :photo
end
