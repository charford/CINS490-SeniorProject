class Reference < ActiveRecord::Base
	belongs_to :user
	validates  :user_id,        :presence => true
	validates	 :firstname,      :presence => true
	validates  :lastname,       :presence => true
	validates	 :letter,         :presence => true
  validates  :reference_hash, :presence => true
	#email and phone not required
end
