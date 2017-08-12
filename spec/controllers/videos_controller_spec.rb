require 'rails_helper'

RSpec.describe VideosController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @video = FactoryGirl.create(:video, user_id: @user.id)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================videos#index=======================
  describe 'GET /videos' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get '/videos'
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all videos' do
          get '/videos', headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

   # =======================videos#create=======================
  describe 'POST /videos' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post '/videos', params: { video: { video: File.new(Rails.root + 'public/SampleVideo2.mp4') } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'creates a successful message video' do
          post '/videos', params: { video: { video: Rack::Test::UploadedFile.new('public/SampleVideo2.mp4') } }, headers: @header
          expect(response.status).to eq 201
        end

        it "validates attachment content type" do
          expect(@video.video_content_type).to eq "video/mp4"
        end
      end
    end
  end

  # =======================videos#update=======================
  describe 'PUT /videos/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/videos/#{@video.id}", params: { video: { video: Rack::Test::UploadedFile.new('public/SampleVideo2.mp4') } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/videos/#{@video.id}", params: { video: { video: Rack::Test::UploadedFile.new('public/SampleVideo2.mp4') } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================videos#delete=======================
  describe 'DELETE /videos/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        delete "/videos/#{@video.id}", params: { video: { video_id: @video.id } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'delete the video' do
          delete "/videos/#{@video.id}", params: { video: { video_id: @video.id } }, headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end
end
