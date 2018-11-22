class PackageUser < ApplicationRecord
  belongs_to :package
  belongs_to :user

  enum package_status: { active: 0, expired: 1 }
end
