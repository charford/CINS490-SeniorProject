class AdditionalFact < ActiveRecord::Base
  validates :evaluator_id, :presence => true
  validates :applicant_id, :presence => true
  validates :fact, :presence  => true
  belongs_to :applicant
end