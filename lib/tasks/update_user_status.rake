desc "Expire the user subscription after 15 days free trial"
task :update_user_status => :environment do
  puts "====================task start=========================="
  package = Package.where("lower(name)=(?)", "Free".downcase).first
  User.all.each do |user|
    user_package = user.package_users.where(package_id: package.id)
    user.update(status: 3) && user_package[0].update(package_status: 1) if user_package.length > 0 && user_package[0].package_end_date.present? && user_package[0].package_end_date <= Time.now && user.active? && user.admin?
  end
  puts "====================task end=========================="
end
