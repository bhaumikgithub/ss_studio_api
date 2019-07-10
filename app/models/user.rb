class User < ApplicationRecord
  acts_as_paranoid
  attr_accessor :validate_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 # Callabcks
 after_create :update_home_page_photos, :create_website_detail, :super_admin_confirm_user, :create_categories, :create_about_us, :create_profile_completeness
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
  has_one :theme, dependent: :destroy
  has_one :contact_detail, dependent: :destroy
  has_one :user_logo, dependent: :destroy
  has_one :website_detail, dependent: :destroy
  has_one :profile_completeness, dependent: :destroy
  has_many :package_users, dependent: :destroy
  has_many :packages, through: :package_users
  belongs_to :country
  belongs_to :role

  cattr_accessor :captcha, :is_validate, :created_by
  validate :captcha_code
  validates :domain_name, :format => URI::regexp(%w(http https)), :allow_nil => true
  enum status: { inactive: 0, pending_activation: 1, active: 2, subscription_expire: 3 }
  enum user_type: { "Regular User": 0, "Premium User": 1, "Test User": 2 }
  # Validations
  # validates :country_id,:first_name, :last_name, presence: true
  validates_presence_of :phone, :message => "Please enter phone"
  validates_presence_of :email, :message => "Please enter email"
  validates_presence_of :country_id, :message => "Please select country"
  validates_presence_of :first_name, :message => "Please enter first Name"
  validates_presence_of :last_name, :message => "Please enter last Name"
  validates :email, :alias, uniqueness: true
  validates :alias, format: { with: /\A[a-z][-a-z]*\z/ }
  validates_presence_of :alias, :message => "Please enter alias"
  validates_presence_of :password, :if => Proc.new{ validate_password&.include?('password') }, message: "Please enter password"
  validates :password_confirmation, :presence => true , :if => Proc.new{ validate_password&.include?('password_confirmation') }
  scope :status, -> (status) { where status: status }
  scope :user_type, -> (user_type) { where user_type: user_type }
  scope :plan, -> (plan) { joins(:package_users).where('package_users.package_id = (?) AND package_status = (?) ',plan,0) }

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
    user = User.find_by(alias: name)
  end

  def after_confirmation
    self.reload
    package = Package.where("lower(name)=(?)", "Free".downcase).first
    role = Role.find_by_name('admin')
    plan_start_date = Date.today
    self.update_attributes(status: 2, role_id: role.id)
    self.package_users.create(package_id: package.id, package_start_date: plan_start_date, package_end_date: plan_start_date + 1.year, package_status: 0)
  end

  def update_home_page_photos
    homepage_photo = HomepagePhoto.create!([
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_1.jpg"), is_active: true,user_id: self.id},
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_2.jpg"), is_active: true,user_id: self.id},
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_3.jpg"), is_active: true,user_id: self.id},
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_4.jpg"), is_active: true,user_id: self.id},
    { homepage_image: File.new("public/shared_photos/homepage_photos/image_5.jpg"), is_active: true,user_id: self.id}
  ])
  end

  def create_website_detail
    WebsiteDetail.create!(title: full_name, copyright_text: "© Copyright "+ Time.current.year.to_s + "- "+ full_name + ", All rights reserved", user_id: self.id)
  end

  def create_categories
    Category.create!([
      { category_name: "Reception", user_id: self.id },
      { category_name: "Candid", user_id: self.id },
      { category_name: "Wedding", user_id: self.id },
      { category_name: "Baby Shower", user_id: self.id },
    ])
  end

  def create_about_us
    About.create(title_text: "Hello", description: "This is about us", facebook_link: '', twitter_link: '',instagram_link: '', youtube_link: '',vimeo_link: '', linkedin_link: '',pinterest_link:'',flickr_link:'',google_link: '', user_id: self.id)
  end

  def create_profile_completeness
    ProfileCompleteness.create!( public_album: false, private_album: false, watermark: false, photo: false, about_us: false, service: false, contact_us: false, social_media_link: false, website_detail: false, homepage_gallery_photo: false, youtube_video: false, add_testimonial: false, contact_details: false, next_task: "public_album", total_process: 13, completed_process: 0, user_id: self.id)
  end

  def captcha_code
    errors.add("captcha", "Please Enter valid captcha") if self.captcha != "28" && self.is_validate
  end

  def super_admin_confirm_user
    if self.created_by == "super_admin"
      self.confirm
      self.skip_confirmation_notification!
      SuperAdminUserMailer.new_user_instruction_mail(self.email, self.password, "bhaumikgithub@gmail.com").deliver!
    end
  end

end
