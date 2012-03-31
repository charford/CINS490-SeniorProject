class Activeuser < ActiveRecord::Base
  validates :user_id, :uniqueness => true,
                      :presence => true
  attr_accessible
end
