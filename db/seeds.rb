# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: 'sagar1@gmail.com', password: 'hello123', password_confirmation: 'hello123', first_name: 'sagar', last_name: 'gadani')
contact_details = ContactDetail.create(address: '2nd Floor, Tulsi Complex, Nr Azad Society, Behind Sahajanand College, Ambavadi, Ahmedabad', email: 'johndoe@gmail.com', phone: '+910123456789', user_id: user.id)
service_icons = ServiceIcon.create!([
  { icon_image: "/service_icons/fashion-icon.png", status: 1},
  { icon_image: "/service_icons/kids-icon.png", status: 1},
  { icon_image: "/service_icons/poterait-icon.png", status: 1},
  { icon_image: "/service_icons/product-icon.png", status: 1},
  { icon_image: "/service_icons/wedding-icon.png", status: 1}
])