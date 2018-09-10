class ProfileCompletenesses::ProfileAttributesSerializer < ActiveModel::Serializer
  attributes :id, :album_management, :site_content, :homepage_gallery, :video_portfolio, :testimonial, :contacts, :next_task, :total_process, :completed_process, :percentage

  def percentage
    if object.completed_process == 0
      percentage = 0
    else
      percentage = ( object.completed_process * 100 ) / object.total_process
    end
  end 
end