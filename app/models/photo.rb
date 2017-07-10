class Photo < ApplicationRecord
  require 'paperclip_processors/watermark'
  acts_as_paranoid
  # Callabcks
  after_create :photo_name
  # Associations
  belongs_to :user
  belongs_to :album

  enum status: { inactive: 0, active: 1 }
  cattr_accessor :watermark_url
  # Validations

  has_attached_file :image, :processors => [:watermark] ,
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
    self.update(photo_title: "#{self.album.album_name} photo #{self.id}") 
  end

  # select photo for cover photo and update it as is cover true and privious is false
  def set_as_cover
    self.album.photos.where(is_cover_photo: true).update_all(is_cover_photo: false)
    self.update(is_cover_photo: true)
  end
end
