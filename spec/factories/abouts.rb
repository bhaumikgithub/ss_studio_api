FactoryGirl.define do
  factory :about do
    title_text "title"
    description "title description"
    social_links {{ facebook_link: "https://www.facebook.com", twitter_link: "https://www.twitter.com", instagram_link: "https://www.instagram.com" }}
  end
end
