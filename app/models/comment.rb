class Comment < ActiveRecord::Base
	belongs_to :applicant
	belongs_to :user
end
