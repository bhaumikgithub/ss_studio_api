require 'rails_helper'

RSpec.describe AlbumRecipientsController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @contact = FactoryGirl.create(:contact)
    @album = FactoryGirl.create(:album, user: @user) 
    @album_recipient = FactoryGirl.create(:album_recipient, album: @album, contact: @contact)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================album_recipients#index=======================
  describe 'GET albums/:id/album_recipients' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get "/albums/#{@album.id}//album_recipients"
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all album_recipients' do
          get "/albums/#{@album.id}//album_recipients", headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================album_recipients#create=======================
  describe 'POST albums/:id/album_recipients' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post "/albums/#{@album.id}/album_recipients", params: { album_recipient: { custom_message: 'Testing', email: ["foo@gmail.com", "bar@gmail.com"] } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'create album_recipients' do
          post "/albums/#{@album.id}/album_recipients", params: { album_recipient: { custom_message: 'Testing', email: ["foo@gmail.com", "bar@gmail.com"] } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================album_recipients#delete=======================
  describe 'DELETE /albums/:id/album_recipients/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        delete "/albums/#{@album.id}/album_recipients/#{@album_recipient.id}", params: { album_recipient: { id: @album_recipient.id } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'delete the album' do
          delete "/albums/#{@album.id}/album_recipients/#{@album_recipient.id}", params: { album_recipient: { id: @album_recipient.id } }, headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================album_recipients/:id#resend=======================
  describe 'POST /albums/:id/album_recipients/:id/resend' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post "/albums/#{@album.id}/album_recipients/#{@album_recipient.id}/resend"
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'resend album_recipients' do
          post "/albums/#{@album.id}/album_recipients/#{@album_recipient.id}/resend", headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end
end
