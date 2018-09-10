module ProfileCompleteHelper
  def next_task(resource)
    flag = false
    next_task = ""
    album_management_reverse = [current_resource_owner.profile_completeness.album_management].map! { |h| h.to_a.reverse.to_h }
    new_album_management = album_management_reverse.each{|v| v.replace({"public_album" => v.delete("public_album")}.merge(v))}
    current_resource_owner.profile_completeness.album_management.each do |album_management|
      while(flag == false)
        if album_management[1] == false
          next_task = album_management[0]
          flag = true
        end
      end
    end
    return next_task
  end
end