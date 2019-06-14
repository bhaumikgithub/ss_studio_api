class Video < ApplicationRecord
  
  # Associations
  belongs_to :user

  # Enumerator
  enum video_type: { youtube: 0, vimeo: 1, other: 2 }
  enum status: { published: 0, unpublished: 1 }

  # Callbacks
  before_commit :generate_embed_video_url, on: [ :create, :update ]

  # Validations
  has_attached_file :video, :styles => {
    :medium => { :geometry => "640x480", :format => 'mp4',:convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "200x200#", :format => 'jpg', :time => 10 },
  }, :processors => [:ffmpeg],
  storage: :s3,
  s3_region: ENV['AWS_S3_REGION'],
  s3_credentials: {
    s3_host_name: ENV['AWS_S3_HOST_NAME'],
    bucket: ENV['AWS_S3_BUCKET_PROD'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    },
  :s3_protocol => :https

  validates_attachment_content_type :video, :content_type => ['video/mp4']
  validates :title, :video_url, presence: true

  def generate_embed_video_url
    video_id = (/([\w-]{11})/.match(self.video_url)).to_s
    video_url = "https://www.youtube.com/embed/"+video_id
    self.video_embed_url = video_url
  end
end
