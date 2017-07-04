class Photo < ApplicationRecord
  acts_as_paranoid
  # Callabcks
  after_create :photo_name
  # Associations
  belongs_to :album

  enum status: { inactive: 0, active: 1 }
  # Validations
  
  has_attached_file :image, 
                    styles: {  
                      thumb: "200x200#", 
                      small: "300x300>", 
                      medium: "450x450>" 
                    }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # Scopes

  
  # Methods

  def photo_name
    # binding.pry
    # name = self.album.album_name
    puts "<----------#{self.inspect}------>"
    puts "<--------#{self.album.album_name}--------->"
     self.update(photo_title: "#{self.album.album_name} photo #{self.id}")
  end

end
