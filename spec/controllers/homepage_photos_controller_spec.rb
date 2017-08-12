require 'rails_helper'

RSpec.describe HomepagePhotosController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @photo = FactoryGirl.create(:photo, image: File.new(Rails.root + 'public/watermark.png'), user: @user)
    @homepage_photo = FactoryGirl.create(:homepage_photo, photo: @photo, user: @user)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================homepage_photos#index=======================
  describe 'GET /homepage_photos' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get '/homepage_photos'
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all homepage photos' do
          # puts "===========#{@homepage_photo.inspect}======="
          get '/homepage_photos', headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================homepage_photos#show=======================
  describe 'GET /homepage_photos' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get "/homepage_photos/#{@homepage_photo.id}"
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all homepage photos' do
          get "/homepage_photos/#{@homepage_photo.id}", headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================homepage_photos#create=======================
  describe 'POST /homepage_photos' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post '/homepage_photos', params: { homepage_photo: [{ image: Rack::Test::UploadedFile.new('public/download.jpg') }] }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'create homepage_photos' do
          post '/homepage_photos', params: { homepage_photo: [{ image: Rack::Test::UploadedFile.new('public/download.jpg') }] }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================homepage_photos#select_uploaded_photo=======================
  describe 'PUT /homepage_photos/select_uploaded_photo' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/homepage_photos/select_uploaded_photo", params: { homepage_photo: { photo_id: [@photo.id] } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/homepage_photos/select_uploaded_photo", params: { homepage_photo: { photo_id: [@photo.id] } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================homepage_photos#active_gallery_photo=======================
  describe 'PUT /homepage_photos/active_gallery_photo' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/homepage_photos/active_gallery_photo", params: { homepage_photo: { id: [@homepage_photo.id] } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/homepage_photos/active_gallery_photo", params: { homepage_photo: { id: [@homepage_photo.id] } }, headers: @header
          # puts "=====response============#{response.body.inspect}============="
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================homepage_photos#active=======================
  describe 'GET /homepage_photos/active' do
    context 'Successful' do
        it 'returns active homepage photos' do
          get "/homepage_photos/active"
          expect(response.status).to eq 200
        end
      end
  end
end
