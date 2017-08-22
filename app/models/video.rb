class Video < ApplicationRecord
  
  # Associations
  belongs_to :user

  # Enumerator
  enum video_type: { youtube: 1, vimeo: 2, other: 3 }
  enum status: { publish: 1, unpublish: 2 }

  # Validations
  has_attached_file :video, :styles => {
    :medium => { :geometry => "640x480", :format => 'mp4',:convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "200x200#", :format => 'jpg', :time => 10 },
  }, :processors => [:ffmpeg]

  validates_attachment_content_type :video, :content_type => ['video/mp4']
end
