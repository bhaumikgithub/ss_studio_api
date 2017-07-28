require 'rails_helper'

RSpec.describe AlbumRecipientsController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @contact = FactoryGirl.create(:contact)
    @album = FactoryGirl.create(:album, user: @user) 
    @album_recipient = FactoryGirl.create(:album_recipient, album: @album, contact: @contact)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end
  # =======================album_recipients#create=======================
  describe 'POST /album_recipients' do
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
end
