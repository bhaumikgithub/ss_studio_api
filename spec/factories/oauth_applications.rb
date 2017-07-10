FactoryGirl.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name "MyString"
    uid "MyString"
    secret "MyString"
    redirect_uri "https://localhost:3000"
    scopes "MyString"
    created_at Time.zone.today
    updated_at ""
  end
end
