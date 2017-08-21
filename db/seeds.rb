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

Photo.create(status: "active", image: File.new("public/shared_photos/about/about-thumb.png"), is_cover_photo: false, user_id: 1, imageable_type: "About", imageable_id: about.id)

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
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_1.jpg"), is_active: true,user_id: 1},
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_2.jpg"), is_active: true,user_id: 1},
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_3.JPG"), is_active: true,user_id: 1},
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_4.jpg"), is_active: true,user_id: 1},
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_5.JPG"), is_active: true,user_id: 1}
])

testimonials = Testimonial.create!([
  { client_name: "Hemali Gadani", message: "Sagar, thank you so much for capturing the best moments. The photos are absolutely amazing and honestly I can’t stop looking at them!!! You definitely captured Joy’s sweetness and cheerfulness . Great service and lovely photographs. Again, many thanks to you and the team.  By far the best photographer and I’d recommend to everyone!", status: 'active' },
  { client_name: "Anjali Chauhan", message: "I want to say HUGE thank you to Sagar Gadani for capturing beautiful pictures of our pre-wedding photo shoot. Our pre-wedding photographs were beyond perfect. You have amazing creative skills. The photos are absolutely beautiful, you managed to capture our special day in such an amazing way. Every time we look at the images we can recall all the emotion, the laughs and fun of the day. Thanks again.", status: 'active' }
])

testimonial_photos = Photo.create([
  { status: "active", image: File.new("public/shared_photos/feedback/hemali_gadani.jpeg"), is_cover_photo: false, user_id: 1, imageable_type: "Testimonial", imageable_id: testimonials.first.id },
  { status: "active", image: File.new("public/shared_photos/feedback/anjali_chauhan.jpeg"), is_cover_photo: false, user_id: 1, imageable_type: "Testimonial", imageable_id: testimonials.second.id }
])

Category.create([
  { category_name: "Wedding", status: "active", user_id: 1 },
  { category_name: "Candid", status: "active", user_id: 1 },
  { category_name: "Kids", status: "active", user_id: 1 },
  { category_name: "Model", status: "active", user_id: 1 }
])