module ControllerSpecHelper
  # def token_generator
  #   user = User.create!(email: 'test@example.com', password: 'hello123', password_confirmation: 'hello123')

  #   # user = FactoryGirl.create(:user) 

  #   application = Doorkeeper::Application.create!(name: 'test', uid: '100', redirect_uri: "https://localhost:3000")
  #   token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id, application_id: application.id)
  #   puts "=========in token====="
  #   # return { current_user: user, auth_token: token.token }
  #   return token.token 
  # end

  def token_generator(user)
    application = Doorkeeper::Application.create!(name: 'test', uid: '12312', redirect_uri: "https://localhost:3000")
    token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id, application_id: application.id)
    # puts "=========in token============#{user.inspect}=========="
    # puts "========#{token.inspect}=========="
    return token.token
  end
end