require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # $user = User.create!(email: 'testtest@gmail.com', password: 'hello123', password_confirmation: 'hello123')
  # $application = Doorkeeper::Application.create!(name: 'test', uid: '100', redirect_uri: "https://localhost:3000")
  # $token = Doorkeeper::AccessToken.create!(resource_owner_id: $user.id, application_id: $application.id)
  before do
    @headers = { Authorization: "bearer " + token_generator }
  end

  it "token" do
    puts "====application controller====#{@headers}===="
  end

end
