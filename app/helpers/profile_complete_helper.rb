module ProfileCompleteHelper
  def next_task(key)
    flag = false
    next_task = ""
    album_management_reverse = [current_resource_owner.profile_completeness.album_management].map! { |h| h.to_a.reverse.to_h }
    new_album_management = album_management_reverse.each{|v| v.replace({"public_album" => v.delete("public_album")}.merge(v))}
    album_site_content = current_resource_owner.profile_completeness.site_content.sort_by {|k, v| k == "about_us" ? 0 : k == "service" ? 1 : k == "contact_us" ? 2 : k == "social_media_link" ? 3 : 4 }
    album_site_content_hash = Hash[*album_site_content.flatten]
    profile_completeness_hash = new_album_management[0].merge(album_site_content_hash).merge(current_resource_owner.profile_completeness.homepage_gallery).merge(current_resource_owner.profile_completeness.video_portfolio).merge(current_resource_owner.profile_completeness.testimonial).merge(current_resource_owner.profile_completeness.contacts)
    profile_completeness_hash.each do |k,v|
      if k != key && v == false
        next_task =  k
        break
      end
    end
    return next_task
  end
end