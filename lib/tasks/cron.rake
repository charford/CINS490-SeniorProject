task :cron => :environment do
  puts "Pulling new requests..."
  ResetRequest.find(:all, :conditions => ["created_at < ?", 1.hour.ago]).each do |request|
  	request.destroy
  	puts "destroyed request"
  end
  puts "done."
end