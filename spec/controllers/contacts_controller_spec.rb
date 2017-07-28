require 'rails_helper'

RSpec.describe ContactsController, type: :request do
  # let(:user) { FactoryGirl.create(:user) }
  # let(:contact) { FactoryGirl.create(:contact, user: user) }

  before do
    @user = FactoryGirl.create(:user)
    @contact = FactoryGirl.create(:contact, user: @user)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end 

  # =======================contacts#index=======================
  describe 'GET /contacts' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get '/contacts'
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all contacts' do
          get '/contacts', headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end 

  # =====================contacts#show=======================
  # describe 'GET /contacts/:id' do
  #   describe 'unauthorized' do
  #     it "should return unauthorized" do
  #       get "/contacts/#{@contact.id}"
  #       assert_response :unauthorized
  #     end
  #   end
  # end

  # =====================contacts#create=======================
  describe 'POST /contacts' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post '/contacts', params: { contact: { first_name: 'Test' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'create contacts' do
          post '/contacts', params: { contact: { first_name: 'Test', email: 'test1@gmail.com', phone: '9696969697' } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================contacts#update=======================
  describe 'PUT /contacts/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/contacts/#{@contact.id}", params: { contact: { first_name: 'hello' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/contacts/#{@contact.id}", params: { contact: { first_name: 'test test' } }, headers: @header
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['data']['contacts']['first_name']).to eq 'test test'
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================contacts#delete=======================
  describe 'DELETE /contacts/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        delete "/contacts/#{@contact.id}", params: { contact: { contact_id: @contact.id } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'delete the contact' do
          delete "/contacts/#{@contact.id}", params: { contact: { contact_id: @contact.id } }, headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end
end
