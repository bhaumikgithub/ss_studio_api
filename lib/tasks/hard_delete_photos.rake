desc "Hard delete photos after 15 days"
task :hard_delete_photos => :environment do
  puts "====================task hard delete start=========================="
  # @soft_delete_photos = Photo.only_deleted.where('deleted_at >= (?)', Date.current-1.days)
  @soft_delete_photos = Photo.only_deleted.where('deleted_at < (?)', Date.current-15.days)
  @soft_delete_photos.each do |photo|
    photo.really_destroy!
  end
  puts "====================task hard delete end=========================="
end
