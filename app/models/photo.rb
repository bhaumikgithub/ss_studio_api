class Photo < ApplicationRecord
  require 'paperclip_processors/watermark'
  acts_as_paranoid

  # Callabcks
  after_create :photo_name

  # Associations
  belongs_to :imageable, polymorphic: true
  belongs_to :user
  has_many :homepage_photos
  belongs_to :watermark
  has_one :comment

  # Enumerator
  enum status: { inactive: 0, active: 1 }
  cattr_accessor :watermark_url, :apply_watermark, :watermark_thumb_url, :watermark_medium_url, :is_watermark, :is_logo

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
                    :styles => lambda { |attachment|
                      if !attachment.instance.class.is_watermark
                        {
                          :medium => {
                            :geometry => "259x259#",
                            :watermark_path => attachment.instance.class.watermark_thumb_url,
                            :position => "SouthEast"
                          },
                          :thumb => {
                            :geometry => "185x185#",
                            # :watermark_path => attachment.instance.class.watermark_thumb_url,
                            :position => "SouthEast"
                          },
                          :original => {
                            :geometry => '1200>',
                            :watermark_path => attachment.instance.class.watermark_medium_url,
                            :position => 'SouthEast',
                          },
                        }
                        elsif attachment.instance.class.is_logo
                        {
                          :medium => {
                            :geometry => "259x259#",
                            :position => "SouthEast"
                          },
                          :thumb => {
                            :geometry => "185x185#",
                            :position => "SouthEast"
                          },
                          :original => {
                            :geometry => '1200>',
                            :position => 'SouthEast',
                          },
                          :logo => {
                            :geometry => "185x70",
                            :position => 'SouthEast',
                          },
                        }
                      else
                        {
                          :medium => {
                            :geometry => "150x100!",
                          },
                          :thumb => {
                            :geometry => "100x100!"
                          },
                        }
                      end
                    }, default_url: "/shared_photos/missing.png"
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

  def update_user(current_user)
    # binding.pry
    self.update(user_id: current_user.id)
  end
end
