class User < ActiveRecord::Base
  before_save :encrypt_password
  attr_accessor :password
  
  validates :email,                 :presence => true,
                                    :uniqueness => true,
                                    :format => { :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i }
                                    
  validates :firstname,             :presence => true
  
  validates :lastname,              :presence => true
  
  validates :password,              :presence => true,
                                    :confirmation => true
                                    
  validates :password_confirmation, :presence => true

                    
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
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
    "#{username}"
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
end
