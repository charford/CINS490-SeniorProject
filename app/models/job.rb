class Job < ActiveRecord::Base
  belongs_to :hiring_manager

  validates :position, 				          :presence => true
  validates :description,           :presence => true
  validates :requirements,          :presence => true
  validates :hiring_manager_id,     :presence => true
end
