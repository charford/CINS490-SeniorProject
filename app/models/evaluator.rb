class Evaluator < ActiveRecord::Base
  has_many :users
  validates :user_id,   :uniqueness => true,
                    :presence   => true
  attr_accessible :user_id
end
