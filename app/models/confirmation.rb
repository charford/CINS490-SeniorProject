class Confirmation < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true,
                      :uniqueness => true
  validates :confirm_hash, :presence => true,
                           :uniqueness => true
  attr_accessible
end
