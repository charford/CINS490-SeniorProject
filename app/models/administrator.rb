class Administrator < ActiveRecord::Base
  has_many :users
  validates :user_id, :presence => true,
  					  :uniqueness => true
end
