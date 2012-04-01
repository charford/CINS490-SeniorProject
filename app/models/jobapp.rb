class Jobapp < ActiveRecord::Base
  belongs_to :job
  validates :job_id, :uniqueness => true,
          :presence => true
  has_many   :questions, :dependent => :destroy

  accepts_nested_attributes_for :questions
  attr_accessible :job_id, :intro, :published,:questions_attributes
end
