class User < ApplicationRecord
  acts_as_paranoid
  attr_accessor :validate_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 # Callabcks
 after_create :update_home_page_photos, :create_website_detail
 # Associations
  has_many :contacts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :watermarks, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :contact_details, dependent: :destroy 
  has_many :videos, dependent: :destroy
  has_many :homepage_photos, dependent: :destroy 
  has_many :testimonials, dependent: :destroy
  has_many :services, dependent: :destroy

  has_one :about, dependent: :destroy
  has_one :contact_detail, dependent: :destroy
  has_one :user_logo, dependent: :destroy
  has_one :website_detail, dependent: :destroy

  enum status: { inactive: 0, active: 1 }
  # Validations
  validates :password, :presence => true , :if => Proc.new{ validate_password&.include?('password') }
  validates :password_confirmation, :presence => true , :if => Proc.new{ validate_password&.include?('password_confirmation') }

  # Scopes

  # Methods
  def full_name
    return nil if first_name.blank? && last_name.blank?
    return first_name if last_name.blank?
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def self.get_user(name)
    user = User.find_by(first_name: name)
  end

  def update_home_page_photos
    homepage_photo = HomepagePhoto.create!([
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_1.jpg"), is_active: true,user_id: self.id},
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_2.jpg"), is_active: true,user_id: self.id},
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_3.JPG"), is_active: true,user_id: self.id},
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_4.jpg"), is_active: true,user_id: self.id},
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_5.JPG"), is_active: true,user_id: self.id}
  ])
  end

  def create_website_detail
    WebsiteDetail.create!(title: full_name, copyright_text: "© Copyright 2017 - "+ full_name + ", All rights reserved", user_id: self.id)
  end

end
