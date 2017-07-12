class Photo < ApplicationRecord
  require 'paperclip_processors/watermark'
  acts_as_paranoid

  # Callabcks
  after_create :photo_name
  
  # Associations
  belongs_to :imageable, polymorphic: true
  belongs_to :user
  # belongs_to :album
  
  enum status: { inactive: 0, active: 1 }
  cattr_accessor :watermark_url
  
  # Validations
  has_attached_file :image, 
                    :processors => [:watermark],
                    :styles => lambda { |attachment| attachment.instance.image_options[:styles]  }    

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
 
  IMAGE_OPTIONS = {
    
    "Watermark": {
      styles: {
        small: ["250x250#"],
        medium: ["300x300#"],
        thumb: ["400x400#"]
      } 
    },
    "Album": {
      styles: {
        small: ["250x250#", :watermark_path => watermark_url],
        medium: ["300x300#",:watermark_path => watermark_url],
        thumb: ["400x400#",:watermark_path => watermark_url]
      }
    }
  }
  # Scopes
  
  # Methods
  # For the dynamic styles of photo
  def image_options
    IMAGE_OPTIONS[self.imageable_type]
  end
  # create default photo_title
  def photo_name
    if imageable_type == "Album"
      self.update(photo_title: "#{self.imageable.album_name} photo #{self.id}") 
    end
  end

  # select photo for cover photo and update it as is cover true and privious is false
  def set_as_cover
    if imageable_type == "Album"
      self.imageable.photos.where(is_cover_photo: true).update_all(is_cover_photo: false)
      self.update(is_cover_photo: true)
    end
  end
end
