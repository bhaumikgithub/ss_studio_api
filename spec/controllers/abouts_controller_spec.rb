require 'rails_helper'

RSpec.describe AboutsController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @photo = FactoryGirl.create(:photo, image: File.new(Rails.root + 'public/watermark.png'), user_id: @user.id)
    @about = FactoryGirl.create(:about)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================abouts#show=======================
  describe 'GET /abouts' do
    describe 'authorized' do
      context 'Successful' do
        it 'returns all abouts' do
          get '/abouts'
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================abouts#update=======================
  describe 'PUT /abouts/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/abouts", params: { about: { title: 'title present' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/abouts", params: { about: { title_text: 'hello', description: 'description' } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end
end
