class Photo < ApplicationRecord
  require 'paperclip_processors/watermark'
  acts_as_paranoid
  # Callabcks
  after_create :photo_name
  # before_create :fetch_watermark_url
  # Associations
  belongs_to :user
  belongs_to :album

  enum status: { inactive: 0, active: 1 }
  # Validations
  has_attached_file :image, 
                    :styles => {
                      :medium => {
                        :small => "300x300>", 
                        :thumb => "200x200#", 
                        :geometry => "455x455#",                  
                        :watermark_path => "#{"public"+Watermark.last.watermark_image.path.split('/public')[1]}"
                      }
                    },
                    :processors => [:watermark]
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # Scopes

  # Methods
  # create default photo_title
  def photo_name
    self.update(photo_title: "#{self.album.album_name} photo #{self.id}") 
  end

  # select photo for cover photo and update it as is cover true and privious is false
  def set_as_cover
    self.album.photos.where(is_cover_photo: true).update_all(is_cover_photo: false)
    self.update(is_cover_photo: true)
  end
  
  def self.fetch_watermark_url
    binding.pry
    watermark = "public"+Watermark.last.watermark_image.path.split('/public')[1]
    watermark = File.open(File.join(watermark))
    puts "=====------------#{watermark.inspect}-----------====="
  end
end
