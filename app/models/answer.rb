class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :applicant
  has_attached_file :photo, :path => "resumes/:id/:basename.:extension"
end
