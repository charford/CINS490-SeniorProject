class Job < ActiveRecord::Base
  belongs_to :hiring_manager
  has_many   :applicants, :dependent => :destroy
  has_many   :users, :through => :applicants
 

  validates :position, 				  :presence => true
  validates :description,       :presence => true
  validates :minimum_qualifications,      :presence => true
  validates :hiring_manager_id, :presence => true

  has_one :jobapp, :dependent => :destroy

  def to_param
    @job = Job.find(id)
    "#{id}-#{@job.position.parameterize}"
  end

  def self.search(search)
    if search
      search_condition = "%" + search + "%"
      where('position LIKE ? OR description LIKE ?', search_condition, search_condition)
    else
      scoped
      #all
    end
  end
end
