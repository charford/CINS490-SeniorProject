class Applicant < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  has_many   :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers
  validates :user_id, :uniqueness => { :scope => :job_id},
                      :presence   => true
  validates :job_id,  :presence => true
  has_many :additional_facts

   def to_param
    @user = User.find(user_id)
    "#{id}-#{@user.firstname.parameterize}-#{@user.lastname.parameterize}"
  end
end
