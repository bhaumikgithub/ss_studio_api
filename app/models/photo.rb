class Photo < ApplicationRecord
  acts_as_paranoid
  # Callabcks
  after_create :photo_name
  # Associations
  belongs_to :user
  belongs_to :album

  enum status: { inactive: 0, active: 1 }
  # Validations
  has_attached_file :image, 
                    styles: {  
                      thumb: "200x200#", 
                      small: "300x300>", 
                      medium: "450x450>",
                    }
                    # :processors => [:watermark],
                    # :styles => {
                    #   :medium => {
                    #     :geometry => "455x455#",
                    #     :watermark_path => WaterMark.count > 0 ? "#{WaterMark.last.watermark_image.path}" : "#{Rails.root}/public/images/watermark.png" 
                    #   }
                    # }
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
