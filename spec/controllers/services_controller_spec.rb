require 'rails_helper'

RSpec.describe ServicesController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @service_icon = FactoryGirl.create(:service_icon)
    @service = FactoryGirl.create(:service, service_icon_id: @service_icon.id)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================services#index=======================
  describe 'GET /services' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get '/services'
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all services' do 
          get '/services', headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

# =======================services#show=======================
  describe 'GET /services/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get "/services/#{@service.id}"
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns particular service with associated service_name' do
          get "/services/#{@service.id}", headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================services#create=======================
  describe 'POST /services' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post '/services', params: { service: { service_name: 'hello', description: 'testing testing testing testing' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'create services' do
          post '/services', params: { service: { service_name: 'hello', description: 'testing testing testing testing' } }, headers: @header
          expect(response.status).to eq 201
        end
      end
      context 'Validations are failed' do
        it 'returns 422' do
          post '/services', params: { service: { service_name: 'hello', description: 'hello' } }, headers: @header
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['errors'][0]['detail']).to eq "is too short (minimum is 30 characters)"
          expect(response.status).to eq 422
        end
      end
    end
  end

#   # =======================services#update=======================
  describe 'PUT /services/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/services/#{@service.id}", params: { service: { service_name: 'test hello', description: 'testing testing hello testing testing' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/services/#{@service.id}", params: { service: { service_name: 'test hello', description: 'testing testing hello testing testing' } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================services#delete=======================
  describe 'DELETE /services/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        delete "/services/#{@service.id}", params: { service: { service_id: @service.id } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'delete the service' do
          delete "/services/#{@service.id}", params: { service: { service_id: @service.id } }, headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

end
