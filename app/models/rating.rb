class Rating < ActiveRecord::Base
  has_many :applicants
  has_many :evaluators
  validates :applicant_id,  :uniqueness => { :scope => :evaluator_id },
                            :presence => true
  validates :evaluator_id,  :presence => true
  validates_numericality_of :rating, :less_than_or_equal_to => 5,
  									                 :greater_than_or_equal_to => 0
  validates :rating,        :presence => true
  attr_accessible :applicant_id, :evaluator_id, :rating, :comment
end
