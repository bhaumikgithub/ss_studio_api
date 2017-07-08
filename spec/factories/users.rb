# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email 'hello@gmail.com'
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.zone.today
    first_name 'MyString'
    last_name 'MyString'
    status 1
  end
end
