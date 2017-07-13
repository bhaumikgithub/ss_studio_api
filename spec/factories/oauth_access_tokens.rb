FactoryGirl.define do
  factory :oauth_access_token, class: 'Doorkeeper::AccessToken' do
    resource_owner_id 1
    application_id 1
    token "MyString"
    refresh_token "MyString"
    expires_in 7200
    scopes "MyString"
    created_at Time.zone.today
    revoked_at ""
    previous_refresh_token "MyString"
  end
end
