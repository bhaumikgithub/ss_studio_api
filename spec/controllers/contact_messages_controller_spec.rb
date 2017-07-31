require 'rails_helper'

RSpec.describe ContactMessagesController, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @contact_message = FactoryGirl.create(:contact_message) 
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================contact_messages#create=======================

  describe 'contact_messages' do
    describe 'authorized' do
      context 'Successful' do
        it 'creates successfully contact messages' do
          post '/contact_messages', params: { contact_message: { name: 'tps', email: 'tps@example.com', phone: '9874123650', message: 'Did not get album link' } }, headers: @header
          # puts "============#{response.body.inspect}========"
          expect(response.status).to eq 201
        end
      end

      context 'Validations are failed' do
        it 'return 422' do
          post '/contact_messages', params: { contact_message: { name: 'tps', email: '', phone: '9874123650', message: 'Did not get album link' } }, headers: @header
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['errors'][0]['detail']).to eq "can't be blank"
        end
      end
    end
  end
end
