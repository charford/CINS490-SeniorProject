class Administrator < ActiveRecord::Base
  has_many :users
  validates :user_id, :presence => true,
  					  :uniqueness => true
  attr_accessible :user_id
end
