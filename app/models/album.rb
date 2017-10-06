class Album < ApplicationRecord
  acts_as_paranoid

  extend FriendlyId
  friendly_id :album_name, use: :slugged
  # Callabcks
  after_create :generate_passcode
  # Associations
  belongs_to :user
  has_many :album_categories
  has_many :categories, through: :album_categories, dependent: :destroy
  has_many :photos, as: :imageable, dependent: :destroy
  has_many :album_recipients, dependent: :destroy

  enum status: { inactive: 0, active: 1 }
  enum delivery_status: {  New: 0 , Shared: 1, Submitted: 2, Delivered: 3, Stoped_selection: 4 }
  # Validations
  validates :album_name, presence: true, :uniqueness => {:case_sensitive => false}
  validates :category_ids,presence: true
  validates_length_of :album_name, :minimum => 3, :maximum => 30
  # Scopes

  # private

  # Methods
  def generate_passcode
    @passcode = SecureRandom.base58(8)
    self.update(passcode: @passcode)
  end
end
