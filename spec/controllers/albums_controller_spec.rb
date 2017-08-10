require 'rails_helper'

RSpec.describe AlbumsController, type: :request do
  # let(:user) { FactoryGirl.create(:user) }
  # let(:album) { FactoryGirl.create(:album, user_id: user.id) }
  before do
    FactoryGirl.create(:album, album_name: 'joy birthday')
    @user = FactoryGirl.create(:user)
    @album = FactoryGirl.create(:album, user_id: @user.id) 
    # @current_user = token_generator[:current_user]
    @header = { Authorization: "bearer " + token_generator(@user) }
    # @header = { Authorization: "bearer " + token_generator[:auth_token] }
  end

  # =======================albums#index=======================
  describe 'GET /albums' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get '/albums'
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all albums' do
          get '/albums', headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================albums#show=======================
  describe 'GET /albums/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get "/albums/#{@album.id}"
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns particular album with associated album_name' do
          get "/albums/#{@album.id}", headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================albums#create=======================
  describe 'POST /albums' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post '/albums', params: { album: { album_name: 'Hinal & Mayur Engagement' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'creates a successful message album' do
          post '/albums', params: { album: { album_name: 'Hinal & Mayur Engagement' } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================albums#update=======================
  describe 'PUT /albums/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/albums/#{@album.id}", params: { album: { album_name: 'marriage' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/albums/#{@album.id}", params: { album: { album_name: 'engagement' } }, headers: @header
          parsed_body = JSON.parse(response.body)
          # puts "==========#{parsed_body['data']['albums']['album_name'].inspect}==============="
          expect(parsed_body['data']['albums']['album_name']).to eq 'engagement'
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================albums#delete=======================
  describe 'DELETE /albums/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        delete "/albums/#{@album.id}", params: { album: { album_id: @album.id } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'delete the album' do
          delete "/albums/#{@album.id}'", params: { album: { album_id: @album.id } }, headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end
end
