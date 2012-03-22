class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
  	#request.ssl? ? con_type = "https://" : con_type = "http://"
  	con_type = "http://"
  	@user = user
  	@confirmation = Confirmation.new
  	@confirmation.user_id = @user.id
  	@confirmation.confirm_hash = secure_hash("#{Time.now.utc}--{created_at}--{firstname}--{email}")
  	@confirmation.save
  	#@url = "#{con_type}#{request.env['HTTP_HOST']}/users/#{@confirmation.user_id}/confirm/#{@confirmation.confirm_hash}"
  	@url = "#{con_type}localhost/users/#{@confirmation.user_id}/confirm/#{@confirmation.confirm_hash}"
  	mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
  
  private
   def secure_hash(string)
      Digest::SHA2.hexdigest(string)
   end
end
