class Watermark < ApplicationRecord
	acts_as_paranoid

  belongs_to :user

  enum status: { inactive: 0, active: 1, deleted: 2 }

  has_attached_file :watermark_image,
                    styles: {  
                      thumb: "200x200#", 
                      small: "300x300>", 
                      medium: "450x450>" 
                    }
  validates_attachment_content_type :watermark_image, :content_type => ["image/png"]

end
