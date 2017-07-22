require 'rails_helper'

RSpec.describe ContactDetailsController, type: :request do
  
  before do
    @user = FactoryGirl.create(:user)
    @contact_detail = FactoryGirl.create(:contact_detail, user_id: @user.id)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================contact_details#update=======================
  describe 'PUT /contact_details/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/contact_details/#{@contact_detail.id}", params: { contact_detail: { address: 'gandhinagar' } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/contact_details/#{@contact_detail.id}", params: { contact_detail: { email: 'test@gmail.com', address: 'baroda' } }, headers: @header
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['data']['contact_details']['address']).to eq 'baroda'
          expect(response.status).to eq 201
        end
      end
    end
  end
end
