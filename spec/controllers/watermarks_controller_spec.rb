require 'rails_helper'

RSpec.describe WatermarksController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @photo = FactoryGirl.create(:photo, image: File.new(Rails.root + 'public/watermark.png'), user: @user)
    @watermark = FactoryGirl.create(:watermark, photo: @photo, user: @user)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================watermarks#index=======================
  describe 'GET /watermarks' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get '/watermarks'
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all watermarks' do
          get '/watermarks', headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================watermarks#create=======================
  describe 'POST /watermarks' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post '/watermarks', params: { watermark: { photo_attributes: { image: Rack::Test::UploadedFile.new('public/download.jpg') } } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'create watermarks' do
          post '/watermarks', params: { watermark: { photo_attributes: { image: Rack::Test::UploadedFile.new('public/download.jpg') } } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================watermarks#update=======================
  describe 'PUT /watermarks/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/watermarks/#{@watermark.id}", params: { watermark: { photo_attributes: { image: Rack::Test::UploadedFile.new('public/download.jpg') } } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/watermarks/#{@watermark.id}", params: { watermark: { photo_attributes: { image: Rack::Test::UploadedFile.new('public/download.jpg') } } }, headers: @header
          # puts "=============#{response.body.inspect}=============="
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================watermarks#delete=======================
  describe 'DELETE /watermarks/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        delete "/watermarks/#{@watermark.id}", params: { watermark: { watermark_id: @watermark.id } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'delete the watermark' do
          delete "/watermarks/#{@watermark.id}", params: { watermark: { watermark_id: @watermark.id } }, headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end
end
