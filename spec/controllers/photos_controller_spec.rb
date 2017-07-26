require 'rails_helper'

RSpec.describe PhotosController, type: :request do
  # let(:photo) { FactoryGirl.create(:photo) }
  before do
    @user = FactoryGirl.create(:user)
    @album = FactoryGirl.create (:album)
    # , image: File.new(Rails.root + 'public/download.jpg')
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
          # puts "=========#{@photo.inspect}=========="
          get '/photos', headers: @header
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

    # describe 'authorized' do
    #   context 'Successful' do
    #     it 'create photos' do
    #       # puts "=========#{@photo.inspect}=========="
    #       puts "=============#{Rack::Test::UploadedFile.new('public/download.jpg').inspect}=============="
    #       # post '/photos', params: { photo: { image: Rack::Test::UploadedFile.new('public/download.jpg') } }, headers: @header
    #       post '/photos', params: { photo: { photo_title: 'xyz' } }, headers: @header

    #       puts "============#{response.body.inspect}============"
    #       expect(response.status).to eq 201
    #     end
    #   end
    # end
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
          puts "=======image======#{Rack::Test::UploadedFile.new('public/download.jpg').inspect}=============="

          puts "=======photo=====#{@photo.inspect}================"
          put "/photos/#{@photo.id}", params: { photo: { photo_title: 'title here', image: Rack::Test::UploadedFile.new('public/download.jpg') } }, headers: @header
          puts "===========#{response.body.inspect}=============="
          expect(response.status).to eq 201
        end
      end
    end
  end
end
