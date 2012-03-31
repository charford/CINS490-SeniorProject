class AdditionalFact < ActiveRecord::Base
  validates :evaluator_id, :presence => true
  validates :applicant_id, :presence => true
  validates :fact, :presence  => true
  belongs_to :applicant
  attr_accessible :evaluator_id, :applicant_id, :fact
end