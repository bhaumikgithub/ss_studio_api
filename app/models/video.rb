class Video < ApplicationRecord
  
  # Associations
  belongs_to :user

  # Validations
  has_attached_file :video, :styles => {
    :medium => { :geometry => "640x480", :format => 'mp4',:convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "200x200#", :format => 'jpg', :time => 10 },
  }, :processors => [:ffmpeg]

  validates_attachment_content_type :video, :content_type => ['video/mp4']
end
