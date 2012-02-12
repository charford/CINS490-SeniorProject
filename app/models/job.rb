class Job < ActiveRecord::Base
  belongs_to :hiring_manager
  has_many   :applicants
  has_many   :users, :through => :applicants
 

  validates :position, 				  :presence => true
  validates :description,       :presence => true
  validates :minimum_qualifications,      :presence => true
  validates :hiring_manager_id, :presence => true

  has_one :jobapp

  def to_param
    @job = Job.find(id)
    "#{id}-#{@job.position.parameterize}"
  end
end
