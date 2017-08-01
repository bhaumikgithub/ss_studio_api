# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'sagar1@gmail.com', password: 'hello123', password_confirmation: 'hello123', first_name: 'sagar', last_name: 'gadani')

contact_details = ContactDetail.create(address: "2nd floor, Tulsi complex, Nr Azad Society,\nBehind Sahjanand Collage, Ambavadi,\nAhemedabad-380 015, Gujarat, India.", email: "johndoe@gmail.com", phone: "+910123456789")

about = About.create(title_text: "A young photographer taking lovely shots", description: "We are capture best moments which is impossible to recapture\nI have worked with over the year........ Stay in touch with Sagar Gadani. Thank you for visiting the website.", facebook_link: "https://www.facebook.com", twitter_link: "https://www.twitter.com", instagram_link: "https://www.instagram.com")

Photo.create(status: "active", image: File.new("public/shared_photos/about/about-thumb.png"), is_cover_photo: false, user_id: 4, imageable_type: "About", imageable_id: about.id)

service_icons = ServiceIcon.create!([
  { icon_image: "/shared_photos/service_icons/fashion-icon.png", status: 1},
  { icon_image: "/shared_photos/service_icons/kids-icon.png", status: 1},
  { icon_image: "/shared_photos/service_icons/poterait-icon.png", status: 1},
  { icon_image: "/shared_photos/service_icons/product-icon.png", status: 1},
  { icon_image: "/shared_photos/service_icons/wedding-icon.png", status: 1}
])

service = Service.create([
  { service_name: "Wedding Photography", description: "It was popularised in the 1960s with the release of the Letraset sheets containing", status: 1, service_icon_id:  service_icons.fifth.id },
  { service_name: "Product Photography", description: "It was popularised in the 1960s with the release of the Letraset sheets containing", status: 1, service_icon_id:  service_icons.fourth.id },
  { service_name: "Portrait Photography", description: "It was popularised in the 1960s with the release of the Letraset sheets containing", status: 1, service_icon_id:  service_icons.third.id },
  { service_name: "Fashion Photography", description: "It was popularised in the 1960s with the release of the Letraset sheets containing", status: 1, service_icon_id:  service_icons.first.id },
  { service_name: "Kids Photography", description: "It was popularised in the 1960s with the release of the Letraset sheets containing", status: 1, service_icon_id:  service_icons.second.id }
  ])

homepage_photo = HomepagePhoto.create!([
  { homepage_image: File.new("public/shared_photos/homepage_photos/background_sky.jpg"), is_active: true,user_id: 1},
  { homepage_image: File.new("public/shared_photos/homepage_photos/dark_pink.jpg"), is_active: true,user_id: 1},
  { homepage_image: File.new("public/shared_photos/homepage_photos/flowers_in_heart.jpg"), is_active: true,user_id: 1},
  { homepage_image: File.new("public/shared_photos/homepage_photos/girl_with_flower.jpg"), is_active: true,user_id: 1},
  { homepage_image: File.new("public/shared_photos/homepage_photos/pink_road.jpg"), is_active: true,user_id: 1}
  ])