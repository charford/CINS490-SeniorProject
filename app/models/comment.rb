class Comment < ActiveRecord::Base
  belongs_to :applicant
  validates :body, :presence => true
  validates :user_id, :presence => true
  validates :applicant_id, :presence => true
  #belongs_to :user
end