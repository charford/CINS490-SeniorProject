class Question < ActiveRecord::Base
	belongs_to :job
	# has_many   :answers
	# validates :job_id, :presence => true
	# validates :body,   :presence => true
end
