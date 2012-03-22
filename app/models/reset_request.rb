class ResetRequest < ActiveRecord::Base
	has_many :users
  validates :user_id, :presence => true #need to add scope here
  validates :request_hash, :presence => true
end
