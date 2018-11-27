class IpDetail < ApplicationRecord
  has_many :album_ip_detail
  has_many :albums, through: :album_ip_details
end
