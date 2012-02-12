class Question < ActiveRecord::Base
	belongs_to :jobapp
	# has_many   :answers
	# validates :job_id, :presence => true
	# validates :body,   :presence => true
end
