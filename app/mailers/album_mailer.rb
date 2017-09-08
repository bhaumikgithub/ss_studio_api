class AlbumMailer < ApplicationMailer
	def album_submitted_notification_to_user(album, contact, total_photos, selected_photos, is_private)
    @album = album
    @contact = contact
    @total_photos = total_photos
    @selected_photos = selected_photos
    @is_private = is_private
    mail(to: contact["email"], subject: "Album Submitted")
  end

  def album_submitted_notification_to_admin(album, total_photos, selected_photos)
  	@album = album
    @total_photos = total_photos
    @selected_photos = selected_photos
    mail(to: "photo.gadani51@gmail.com", subject: "Album Submitted")
  end
end
