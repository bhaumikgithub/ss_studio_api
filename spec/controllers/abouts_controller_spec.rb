require 'rails_helper'

RSpec.describe AboutsController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @photo = FactoryGirl.create(:photo, image: File.new(Rails.root + 'public/watermark.png'), user_id: @user.id)
    @about = FactoryGirl.create(:about, photo: @photo)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================abouts#index=======================
  describe 'GET /abouts' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get '/abouts'
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all abouts' do
          get '/abouts', headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================abouts#update=======================
  describe 'PUT /abouts/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/abouts/#{@about.id}", params: { about: { title: 'title present' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          # puts "=============#{Rack::Test::UploadedFile.new('public/download.jpg')}=============="
          put "/abouts/#{@about.id}", params: { about: { title: 'hello', photo_attributes: { image: Rack::Test::UploadedFile.new('public/download.jpg'), id: @about.photo.id } } }, headers: @header
          # puts "===========#{response.body.inspect}=============="
          expect(response.status).to eq 201
        end
      end
    end
  end
end
