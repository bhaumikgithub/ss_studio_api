class ProfileCompletenesses::ProfileAttributesSerializer < ActiveModel::Serializer
  attributes :id, :album_management, :site_content, :homepage_gallery, :video_portfolio, :testimonial, :contacts, :next_task, :total_process, :completed_process, :percentage, :parent_accessor, :completeness_status, :total_album, :public_album, :private_album

  def percentage
    if object.completed_process == 0
      percentage = 0
    else
      percentage = ( object.completed_process * 100 ) / object.total_process
    end
  end

  #Parent_accesor is not used
  def parent_accessor
  	# if object.next_task == 'public_album' || object.next_task == 'private_album' || object.next_task == 'watermark' ||object.next_task == 'photo'
  	# 	'Album Management'
  	# elsif object.next_task == 'service' || object.next_task == 'about_us' || object.next_task == 'contact_us' || object.next_task == 'website_detail' || object.next_task == 'social_media_links'
  	# 	'Site Content'
  	# elsif object.next_task == 'homepage_gallery_photo'
  	# 	'Homepage Gallery'
 		# elsif object.next_task == 'youtube_video'
  	# 	'Video Portfolio'
  	# elsif object.next_task == 'add_testimonial'
  	# 	'Testimonial'
  	# elsif object.next_task == 'contact_details'
  	# 	'Contacts'
  	# end
  end

  def completeness_status
  	 album = object.album_management.values.include?(false) ? false : true
  	 site_content = object.site_content.values.include?(false) ? false : true
  	 homepage_gallery = object.homepage_gallery.values.include?(false) ? false : true
  	 video_portfolio = object.video_portfolio.values.include?(false) ? false : true
  	 testimonial = object.testimonial.values.include?(false) ? false : true
  	 contacts = object.contacts.values.include?(false) ? false : true

  	{album_management: album, site_content: site_content, homepage_gallery: homepage_gallery, video_portfolio: video_portfolio, testimonial: testimonial, contacts: contacts}
  end

  def total_album
    object.user.albums.count
  end

  def public_album
    object.user.albums.where(is_private: false).count
  end

  def private_album
    object.user.albums.where(is_private: true).count
  end
end