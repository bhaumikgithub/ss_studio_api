class AlbumMailer < ApplicationMailer
	def album_submitted_notification_to_user(album, admin_email, contact, total_photos, selected_photos, is_private)
    @album = album
    @contact = contact
    @total_photos = total_photos
    @selected_photos = selected_photos
    @is_private = is_private
    mail(from: admin_email, to: contact["email"], subject: "Album Submitted")
  end

  def album_submitted_notification_to_admin(album, admin_email, total_photos, selected_photos)
  	@album = album
    @total_photos = total_photos
    @selected_photos = selected_photos
    mail(from: admin_email, to: admin_email, subject: "Album Submitted")
  end
end
