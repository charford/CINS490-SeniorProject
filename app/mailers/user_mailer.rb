class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user,host_url,con_type)
  	#request.ssl? ? con_type = "https://" : con_type = "http://"
  	@user = user
  	@confirmation = Confirmation.new
  	@confirmation.user_id = @user.id
  	@confirmation.confirm_hash = secure_hash("#{Time.now.utc}--{created_at}--{firstname}--{email}")
  	@confirmation.save
  	@url = "#{con_type}#{host_url}/users/#{@confirmation.user_id}/confirm/#{@confirmation.confirm_hash}"
  	mail(:to => user.email, :subject => "Welcome to JobMe! Account activation required.")
  end

  def request_reference(user,ref_email,host_url,con_type)
    @user = user
    @url = "#{con_type}#{host}/references/#{user.id}/#{user.reference_hash}"
    mail(:to => ref_email, :subject => "#{user} has requested a reference from you.")
  end

  def reset_request(user,host_url,con_type)
    @reset_request = ResetRequest.new
    @reset_request.user_id = user.id
    @reset_request.request_hash = secure_hash("#{Time.now.utc}--{created_at}--{firstname}--{email}")
    @reset_request.save
    @url = "#{con_type}#{host_url}/reset/#{@reset_request.request_hash}"
    mail(:to => user.email, :subject => "Follow this link to reset your password.")
  end

  private
   def secure_hash(string)
      Digest::SHA2.hexdigest(string)
   end
end
