class Applicant < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  has_many   :comments
  has_many :ratings
  validates :user_id, :uniqueness => { :scope => :job_id},
                      :presence   => true
  validates :job_id,  :uniqueness => true

   def to_param
    @user = User.find(user_id)
    "#{id}-#{@user.firstname.parameterize}-#{@user.lastname.parameterize}"
  end
end