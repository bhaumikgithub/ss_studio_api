FactoryGirl.define do
  factory :contact do
    first_name "test"
    last_name "test"
    email "test@gmail.com"
    phone "9696969696"
    status true
    user nil
    created_at ""
    updated_at ""
    deleted_at ""
    token "MyString"
  end
end
