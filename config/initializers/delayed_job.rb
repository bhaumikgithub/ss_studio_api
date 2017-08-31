Delayed::Worker.logger = Logger.new("log/delayed_job.log", 5, 104857600)

if caller.last =~ /bin\/delayed_job/ or (File.basename($0) == "rake" and ARGV[0] =~ /jobs\:work/)
  ActiveRecord::Base.logger = Delayed::Worker.logger
end