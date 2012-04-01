class ResetRequest < ActiveRecord::Base
  validates :user_id, :presence => true #need to add scope here
  validates :request_hash, :presence => true
  attr_accessible :user_id, :request_hash
  belongs_to :user
end
