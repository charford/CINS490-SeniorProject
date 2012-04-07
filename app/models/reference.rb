class Reference < ActiveRecord::Base
  belongs_to :user
  validates  :user_id,        :presence => true
  validates	 :firstname,      :presence => true
  validates  :lastname,       :presence => true
  validates	 :letter,         :presence => true
  validates  :reference_hash, :presence => true
  has_attached_file :photo, :path => "references/:id/:basename.:extension"
  attr_accessible :user_id, :firstname, :lastname, :email, :phone, :letter, :reference_hash
	#email and phone not required

  def request_for_reference
    @subject = "Email sent via your website"
    @body['message'] = "hello world"
    @recipients = "casey@caseyharford.com"
    @from = "user@joe.com"
    @sent_on = Time.now
    @headers = {}
  end	
end
