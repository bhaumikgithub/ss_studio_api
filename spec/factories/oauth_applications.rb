FactoryGirl.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name "MyString"
    uid "MyString"
    secret "MyString"
    redirect_uri "https://localhost:3000"
    scopes "MyString"
    created_at "2017-07-07 11:36:48"
    updated_at "2017-07-07 11:36:48"
  end
end
