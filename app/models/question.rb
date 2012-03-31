class Question < ActiveRecord::Base
	belongs_to :jobapp
	# has_many   :answers
	# validates :job_id, :presence => true
	# validates :body,   :presence => true
	attr_accessible :job_id, :body, :qtype, :jobapp_id, :choice_a, :choice_b, :choice_c, :choice_d
end
