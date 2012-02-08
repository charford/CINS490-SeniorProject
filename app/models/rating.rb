class Rating < ActiveRecord::Base
  has_many :applicants
  has_many :evaluators
  validates :applicant_id, :uniqueness => { :scope => :evaluator_id }
end
