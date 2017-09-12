# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'sagar1@gmail.com', password: 'hello123', password_confirmation: 'hello123', first_name: 'sagar', last_name: 'gadani')

contact_details = ContactDetail.create(address: "7 Ekta Tower,\nOpposite Swastik Apartment, \nVasna, Ahmedabad - 380007", email: "photo.gadani51@gmail.com", phone: "+919662044902")

about = About.create(title_text: "A young photographer taking lovely shots", description: "I thought that instead of me bragging about how good I am and how amazing my work is and how second to none is my customer service, I'll let others do the talking. Here are some of the exceptional individuals I have worked with over the years........ Stay in touch with Sagar Gadani. Thank you for visiting the website.", facebook_link: "https://www.facebook.com/sagarphotocam", twitter_link: "https://www.twitter.com", instagram_link: "https://www.instagram.com")

Photo.create(status: "active", image: File.new("public/shared_photos/about/about-thumb.png"), is_cover_photo: false, user_id: user.id, imageable_type: "About", imageable_id: about.id)

service_icons = ServiceIcon.create!([
  { icon_image: "/shared_photos/service_icons/wedding-icon.png", status: 1},
  { icon_image: "/shared_photos/service_icons/pre-wedding-icon.png", status: 1},
  { icon_image: "/shared_photos/service_icons/candid-icon.png", status: 1},
  { icon_image: "/shared_photos/service_icons/model-icon.png", status: 1},
  { icon_image: "/shared_photos/service_icons/couple-icon.png", status: 1},
  { icon_image: "/shared_photos/service_icons/kids-icon.png", status: 1},
])

service = Service.create([
  { service_name: "Wedding Photography", description: "We offer different packages for Wedding Photography. Capture your special day moments with us! After all, Wedding is the special event in anyone's life.", status: 1, service_icon_id:  service_icons[0].id },
  { service_name: "Pre-Wedding Photography", description: "We provide themed Pre-Wedding photography & videography. We capture and bring emotion in the motions of Life.  Make your pre-wedding days memorable!", status: 1, service_icon_id:  service_icons[1].id },
  { service_name: "Candid Photography", description: "We love clicking Candid Photographs, of the unexpected moments. We capture your Smile, Love and Joy with light composition of Candid Shots. It's about capturing Perfect Moment. ", status: 1, service_icon_id:  service_icons[2].id },
  { service_name: "Model Shoot", description: "We are highly instrumental in offering Modelling photography services to the clients. our services includes Fashion Photography, Modelling Photo Shoot and Modelling Services.", status: 1, service_icon_id:  service_icons[3].id },
  { service_name: "Couple Photography", description: "We are expert in Couple Shoot During the Couple Shoot, we create a Story for you and provide Props. Contact us to get a memorable gift for you and your partner in future!", status: 1, service_icon_id:  service_icons[4].id },
  { service_name: "Kids Photography", description: "We undertake indoor and outdoor Kids Photo Shoots. Families have preferred this Kids Photography to have the whole time with lasting memories and also to fill walls within framed professional stills. ", status: 1, service_icon_id:  service_icons[5].id }
])

homepage_photo = HomepagePhoto.create!([
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_1.jpg"), is_active: true,user_id: user.id},
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_2.jpg"), is_active: true,user_id: user.id},
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_3.JPG"), is_active: true,user_id: user.id},
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_4.jpg"), is_active: true,user_id: user.id},
  { homepage_image: File.new("public/shared_photos/homepage_photos/image_5.JPG"), is_active: true,user_id: user.id}
])

testimonials = Testimonial.create!([
  { client_name: "Hemali Gadani", message: "Sagar, thank you so much for capturing the best moments. The photos are absolutely amazing and honestly I can’t stop looking at them!!! You definitely captured Joy’s sweetness and cheerfulness . Great service and lovely photographs. Again, many thanks to you and the team.  By far the best photographer and I’d recommend to everyone!", status: 'active' },
  { client_name: "Anjali Chauhan", message: "I want to say HUGE thank you to Sagar Gadani for capturing beautiful pictures of our pre-wedding photo shoot. Our pre-wedding photographs were beyond perfect. You have amazing creative skills. The photos are absolutely beautiful, you managed to capture our special day in such an amazing way. Every time we look at the images we can recall all the emotion, the laughs and fun of the day. Thanks again.", status: 'active' },
  { client_name: "Apurva Chauhan", message: "The best thing of your photography is how you conversate with your camera while clicking. You have an immense hold on poses, design, edition, crafting and ofcourse creativity in any occasion whatever you are brought forth for. Good Luck.", status: 'active' },
  { client_name: "Vaibhav Prakash", message: "Good Work and More Creativity you bring to the Photography. Thank you and I wish you a good luck.", status: 'active' }
])

testimonial_photos = Photo.create([

  { status: "active", image: File.new("public/shared_photos/feedback/hemali_gadani.jpeg"), is_cover_photo: false, user_id: user.id, imageable_type: "Testimonial", imageable_id: testimonials.first.id },
  { status: "active", image: File.new("public/shared_photos/feedback/anjali_chauhan.jpeg"), is_cover_photo: false, user_id: user.id, imageable_type: "Testimonial", imageable_id: testimonials.second.id },
  { status: "active", image: File.new("public/shared_photos/feedback/apurva_chauhan.jpg"), is_cover_photo: false, user_id: user.id, imageable_type: "Testimonial", imageable_id: testimonials.third.id },
  { status: "active", image: File.new("public/shared_photos/feedback/vaibhav_prakash.jpg"), is_cover_photo: false, user_id: user.id, imageable_type: "Testimonial", imageable_id: testimonials.fourth.id }
])

Category.create([
  { category_name: "Wedding", status: "active", user_id: user.id },
  { category_name: "Pre-wedding", status: "active", user_id: user.id },
  { category_name: "Candid", status: "active", user_id: user.id },
  { category_name: "Model", status: "active", user_id: user.id },
  { category_name: "Couple", status: "active", user_id: user.id },
  { category_name: "Kids", status: "active", user_id: user.id }
])

watermark = Watermark.create(user_id: user.id, status: 1)

Photo.is_watermark = true
Photo.create(status: "active", image: File.new("public/shared_photos/watermark.png"), user_id: user.id, imageable_type: "Watermark", imageable_id: watermark.id)
Photo.is_watermark = false