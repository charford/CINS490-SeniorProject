class HiringManager < ActiveRecord::Base
	has_many :users
	has_many :job
	validates :user_id, :uniqueness => true,
						:presence => true	
end
