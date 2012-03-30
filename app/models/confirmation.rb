class Confirmation < ActiveRecord::Base
  has_many :users
  validates :user_id, :presence => true,
                      :uniqueness => true
  validates :confirm_hash, :presence => true,
                           :uniqueness => true
  attr_accessible
end
