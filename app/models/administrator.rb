class Administrator < ActiveRecord::Base
  has_many :users
end
