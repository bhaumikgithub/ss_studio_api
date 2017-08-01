# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'sagar1@gmail.com', password: 'hello123', password_confirmation: 'hello123', first_name: 'sagar', last_name: 'gadani')

contact_details = ContactDetail.create(address: '2nd Floor, Tulsi Complex, Nr Azad Society, Behind Sahajanand College, Ambavadi, Ahmedabad', email: 'johndoe@gmail.com', phone: '+910123456789')

about = About.create(title_text: "A young photographer taking lovely shots", description: "We are capture best moments which is impossible to recapture\nI have worked with over the year........ Stay in touch with Sagar Gadani. Thank you for visiting the website.", facebook_link: "www.facebook.com", twitter_link: "www.twitter.com", instagram_link: "www.instagram.com")

Photo.create(status: "active", image: File.new("public/share_photos/about/about-thumb.png"), is_cover_photo: false, user_id: 4, imageable_type: "About", imageable_id: about.id)

service_icons = ServiceIcon.create!([
  { icon_image: "/share_photos/service_icons/fashion-icon.png", status: 1},
  { icon_image: "/share_photos/service_icons/kids-icon.png", status: 1},
  { icon_image: "/share_photos/service_icons/poterait-icon.png", status: 1},
  { icon_image: "/share_photos/service_icons/product-icon.png", status: 1},
  { icon_image: "/share_photos/service_icons/wedding-icon.png", status: 1}
])

homepage_photo = HomepagePhoto.create!([
  {homepage_image_file_name: "/system/homepage_photos/homepage_images/background_sky.jpg",homepage_image_content_type: "image/jpeg", homepage_image_file_size: 22447, homepage_image_updated_at: Time.now , is_active: true,user_id: 1},
  {homepage_image_file_name: "/system/homepage_photos/homepage_images/dark_pink.jpg",homepage_image_content_type: "image/jpeg", homepage_image_file_size: 12614, homepage_image_updated_at: Time.now , is_active: true,user_id: 1},
  {homepage_image_file_name: "/system/homepage_photos/homepage_images/flowers_in_heart.jpg",homepage_image_content_type: "image/jpeg", homepage_image_file_size: 12817, homepage_image_updated_at: Time.now , is_active: true,user_id: 1},
  {homepage_image_file_name: "/system/homepage_photos/homepage_images/girl_with_flower.jpg", homepage_image_content_type: "image/jpeg", homepage_image_file_size: 7964, homepage_image_updated_at: Time.now , is_active: true,user_id: 1},
  {homepage_image_file_name: "/system/homepage_photos/homepage_images/pink_road.jpg", homepage_image_content_type: "image/jpeg", homepage_image_file_size: 16721, homepage_image_updated_at: Time.now , is_active: true,user_id: 1}
  ])