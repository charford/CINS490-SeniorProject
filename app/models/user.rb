class User < ActiveRecord::Base
  before_save :encrypt_password
  before_save :generate_reference_hash
  before_destroy :remove_from_groups
  attr_accessor :password
  
  validates   :email,                 :presence => true,
                                      :uniqueness => true,
                                      :format => { :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i }
                                    
  validates   :firstname,             :presence => true
  
  validates   :lastname,              :presence => true
  
  validates   :password,              :presence => true,
                                      :confirmation => true
                                    
  validates   :password_confirmation, :presence => true
  # validate    :password_must_be_present
  validates   :reference_hash,        :uniqueness => true
  has_many    :applicants, :dependent => :destroy
  has_many    :jobs,                  :through => :applicants
  belongs_to  :evaluator
  belongs_to  :hiringmanager
  belongs_to  :administrator
  has_many    :references, :dependent => :destroy
  has_one     :confirmation
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return nil if !Activeuser.find_by_user_id(user.id)
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def to_param
    "#{id}-#{firstname.parameterize}-#{lastname.parameterize}"
  end
  
  def to_s
    "#{firstname.capitalize} #{lastname.capitalize}"
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def generate_reference_hash
      self.reference_hash = secure_hash("#{Time.now.utc}--{firstname}--{lastname}--{email}")
    end

    def password_must_be_present
      return if params[:action] == "edit"
      if(self.password).blank?
        errors.add(:password, "can't be blank.")
      end
      if(self.password_confirmation).blank?
        errors.add(:password_confirmation, "can't be blank.")
      end
    end

    def remove_from_groups
      Administrator.find_by_user_id(self.id) ? Administrator.find_by_user_id(self.id).destroy : nil
      HiringManager.find_by_user_id(self.id) ? HiringManager.find_by_user_id(self.id).destroy : nil
      Evaluator.find_by_user_id(self.id) ? Evaluator.find_by_user_id(self.id).destroy : nil
    end
end
