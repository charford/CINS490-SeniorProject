class Jobapp < ActiveRecord::Base
	belongs_to :job
	validates :job_id, :uniqueness => true,
					:presence => true
	has_many   :questions

  accepts_nested_attributes_for :questions
  
end
