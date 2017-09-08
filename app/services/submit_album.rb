class SubmitAlbum < BaseService
	attr_accessor :album, :total_photos_count, :selected_photos_count, :is_private

	def initialize(album)
		@album = album
		@total_photos_count = total_photos
		@selected_photos_count = selected_photos
		@is_private = album.is_private
	end

	def call
		if album.delivery_status == "Submitted"
			Success.new(nil, "Album already submitted.", 208)
		else
			submit_album
		end
	end

	private

	def submit_album
		album.update_attributes(delivery_status: "Submitted")
		contacts.each do |contact|
			AlbumMailer.delay.album_submitted_notification_to_user(album, contact.attributes, total_photos_count, selected_photos_count, is_private)
		end
		AlbumMailer.delay.album_submitted_notification_to_admin(album, total_photos_count, selected_photos_count)
		Success.new(nil, "Album successfully submitted.", 201)
	end

	def photos
		album.photos
	end

	def total_photos
		photos.count
	end

	def selected_photos
		photos.where("is_selected = true").count
	end

	def contacts
		album.album_recipients.joins(:contact).select("album_recipients.id as id, contacts.email as email, contacts.token as token")
	end
end