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
  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all
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
  belongs_to :package
  belongs_to :country
  belongs_to :role

  cattr_accessor :captcha, :is_validate
  validate :captcha_code
  enum status: { inactive: 0, pending_activation: 1, active: 2, subscription_expire: 3 }
  # Validations
  validates :alias, :phone, :email, :country_id, presence: true
  validates :email, :alias, uniqueness: true
  validates :password, :presence => true , :if => Proc.new{ validate_password&.include?('password') }
  validates :password_confirmation, :presence => true , :if => Proc.new{ validate_password&.include?('password_confirmation') }

  # Scopes

  ['admin', "super_admin"].each do |user_role|
    define_method "#{user_role}?" do
      self.role.name == user_role
    end
  end

  # Methods
  def full_name
    return nil if first_name.blank? && last_name.blank?
    return first_name if last_name.blank?
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def self.get_user(name)
    user = User.find_by(first_name: name)
  end

  def after_confirmation
    package = Package.find_by_name('free')
    role = Role.find_by_name('admin')
    self.update_attributes(status: 2, package_id: package.id, role_id: role.id)
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

  def captcha_code
    errors.add("captcha","is invalid. Please Enter valid captcha") if self.captcha != "28" && self.is_validate
  end

end
