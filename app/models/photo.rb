class Photo < ApplicationRecord
  require 'paperclip_processors/watermark'
  acts_as_paranoid

  # Callabcks
  after_create :photo_name
  
  # Associations
  belongs_to :imageable, polymorphic: true
  belongs_to :user
  belongs_to :watermark
  
  # Enumerator
  enum status: { inactive: 0, active: 1 }
  cattr_accessor :watermark_url, :apply_watermark
  
  # Validations
  # validates :imageable_id, :imageable_type, presence: true
  has_attached_file :image, 
                    :processors => lambda {|attachment|
                      if attachment.class.apply_watermark
                        [:thumbnail,:watermark]
                      else
                        [:thumbnail]
                      end
                    },
                    :styles => lambda { |attachment| {
                      :small => {
                        :geometry => "250x250#",
                        :watermark_path => attachment.instance.class.watermark_url
                      },
                      :medium => {
                        :geometry => "300x300#",
                        :watermark_path => attachment.instance.class.watermark_url
                      },
                      :thumb => {
                        :geometry => "400x400#",
                        :watermark_path => attachment.instance.class.watermark_url
                      }, 
                    }
                  }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
 
  # Scopes
  
  # Methods
  
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
