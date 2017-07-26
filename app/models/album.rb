class Album < ApplicationRecord
  acts_as_paranoid
  # Callabcks
  after_create :generate_passcode
  # Associations
  belongs_to :user
  has_many :album_categories
  has_many :categories, through: :album_categories, dependent: :destroy
  has_many :photos, as: :imageable, dependent: :destroy
  has_many :album_recipients, dependent: :destroy

  enum status: { inactive: 0, active: 1 }
  enum delivery_status: { brand_new: 0 , shared: 1, submitted: 2, delivered: 3 }
  # Validations
  validates :album_name, presence: true, :uniqueness => true
  validates_length_of :album_name, :minimum => 3, :maximum => 30
  # Scopes

  # private

  # Methods
  def generate_passcode
    @passcode = SecureRandom.base58(8)
    self.update(passcode: @passcode)
  end
end
