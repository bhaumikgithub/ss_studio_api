class Package < ApplicationRecord
	# Associations
	has_many :package_users
  has_many :users, through: :package_users

  enum status: { active: 0, deactive: 1 }
end
