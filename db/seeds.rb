# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# user = User.create(email: 'sagar1@gmail.com', password: 'hello123', password_confirmation: 'hello123', first_name: 'sagar', last_name: 'gadani')
# contact_details = ContactDetail.create(address: '2nd Floor, Tulsi Complex, Nr Azad Society, Behind Sahajanand College, Ambavadi, Ahmedabad', email: 'johndoe@gmail.com', phone: '+910123456789', user_id: user.id)

about = About.create(title_text: "A young photographer taking lovely shots", description: "We are capture best moments which is impossible to recapture", facebook_link: "www.facebook.com", twitter_link: "www.twitter.com", instagram_link: "www.instagram.com")

Photo.create(status: "active", image_file_name: "download.jpg", image_content_type: "image/jpeg", image_file_size: 10017, image_updated_at: Time.now, is_cover_photo: false, user_id: 4, imageable_type: "About", imageable_id: about.id)
