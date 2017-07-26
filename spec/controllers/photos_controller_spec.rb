require 'rails_helper'

RSpec.describe PhotosController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @album = FactoryGirl.create (:album)
    @photo = FactoryGirl.create(:photo, user_id: @user.id, imageable_id: @album.id, imageable_type: @album.class)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================photos#index=======================
  describe 'GET /photos' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get '/photos'
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all photos' do
          get '/photos', headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

# =======================photos#show=======================
  describe 'GET /photos/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get "/photos/#{@photo.id}"
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns particular photo with associated photo_name' do
          get "/photos/#{@photo.id}", headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================photos#create=======================
  describe 'POST /photos' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post '/photos', params: { photo: { imageable_id: @album.id, imageable_type: @album.class } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'create photos' do
          post '/photos', params: { photo: [{ image: Rack::Test::UploadedFile.new('public/download.jpg'), imageable_type: @album.class, imageable_id: @album.id }] }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================photos#update=======================
  describe 'PUT /photos/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/photos/#{@photo.id}", params: { photo: { photo_title: 'title present' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/photos/#{@photo.id}", params: { photo: { photo_title: 'title here', image: Rack::Test::UploadedFile.new('public/download.jpg') } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================photos#delete=======================
  describe 'DELETE /photos/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        delete "/photos/#{@photo.id}", params: { photo: { photo_id: @photo.id } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'delete the photo' do
          delete "/photos/#{@photo.id}", params: { photo: { photo_id: @photo.id } }, headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================photos#set_cover_photo=======================
  describe 'patch /photos/:id/set_cover_photo' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        patch "/photos/#{@photo.id}/set_cover_photo"
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          patch "/photos/#{@photo.id}/set_cover_photo", headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================photos#multi_delete=======================
  describe 'DELETE /photos/multi_delete' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        delete "/photos/multi_delete"
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'delete the photo' do
          delete "/photos/multi_delete", params: { photo: { id: @photo.id } }, headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end
end
