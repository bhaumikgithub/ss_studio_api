FactoryGirl.define do
  factory :album_recipient do
    is_email_sent false
    custom_message "MyString"
    album nil
    contact nil
  end
end
