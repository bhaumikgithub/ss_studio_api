module ControllerSpecHelper
  def token_generator
    user = User.create!(email: 'test@gmail.com', password: 'hello123', password_confirmation: 'hello123')
    application = Doorkeeper::Application.create!(name: 'test', uid: '100', redirect_uri: "https://localhost:3000")
    token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id, application_id: application.id)
    puts "=========in token====="
    return { current_user: user, auth_token: token.token }
  end
end