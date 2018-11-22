class Package < ApplicationRecord
	# Associations
	has_many :package_users
  has_many :users, through: :package_users
end
