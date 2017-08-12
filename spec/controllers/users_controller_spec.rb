require 'rails_helper'

RSpec.describe UsersController, type: :request do

  before do
    @user = FactoryGirl.create(:user)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================users#show=======================
  describe "GET #show" do
    it "returns http success" do
      get "/users/#{@user.id}", headers: @header
      expect(response).to have_http_status(:success)
    end
  end

end
