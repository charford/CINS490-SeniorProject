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
  	mail(:to => user.email, :subject => "Welcome to JobMe! Account activation required.")
  end

  def request_reference(user,ref_email)
    con_type = "http://"
    @user = user
    @url = "http://localhost:3000/references/#{user.id}/#{user.reference_hash}"
    #@request_reference = RequestReference.new
    #@request_reference.request_hash = secure_hash("#{Time.now.utc}--{created_at}--{firstname}--{email}")
    #@request_reference.user_id = @user.id
    #@url = "#{con_type}localhost:3000/references/#{@reference_request.user_id}/#{@reference_request.request_hash}"
    mail(:to => ref_email, :subject => "#{user} has requested a reference from you.")
  end

  def reset_request(user)
    con_type = "http://"
    @reset_request = ResetRequest.new
    @reset_request.user_id = user.id
    @reset_request.request_hash = secure_hash("#{Time.now.utc}--{created_at}--{firstname}--{email}")
    @reset_request.save
    @url = "#{con_type}localhost/reset/#{@reset_request.request_hash}"
    mail(:to => user.email, :subject => "Follow this link to reset your password.")
  end

  private
   def secure_hash(string)
      Digest::SHA2.hexdigest(string)
   end
end
