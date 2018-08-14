desc "Expire the user subscription after 15 days free trial"
task :update_user_status => :environment do
  puts "====================task start=========================="
  package = Package.find_by(name: "free")
  User.all.each do |user|
    after_15_days = user.created_at + 15.days
    user.update(status: 3) if after_15_days <= Time.now && user.package_id == package.id && user.active? && user.admin?
  end
  puts "====================task end=========================="
end
