# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CategoriesController, type: :request do
  let(:category) { FactoryGirl.create(:category) }
  # =======================categories#index=======================
  describe 'GET /categories' do
    let!(:category1) { FactoryGirl.create(:category, category_name: 'category 1') }
    let!(:category2) { FactoryGirl.create(:category, category_name: 'category 2') }
    context 'Successful' do
      it 'returns all categories' do
        get '/categories'
        # parsed_body = JSON.parse(response.body)
        expect(response.status).to eq 200
      end
    end

    context 'Return failed' do
      it 'returns more then two categories' do
        get '/categories'
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['data']['categories'].count).to eq 2
        expect(response.status).to eq 200
      end
    end
  end
  # =======================categories#show=======================
  describe 'GET /categories/:id' do
    context 'Successful' do
      it 'returns particular category with associated category_name' do
        get "/categories/#{category.id}"
        expect(response.status).to eq 200
      end
    end
  end
  # =======================categories#create=======================
  describe 'POST /categories' do
    context 'Successful' do
      it 'creates a successful message category' do
        post '/categories', params: { category: { category_name: 'Engagement' } }
        expect(response.status).to eq 201
      end
    end

    context 'Validations are failed' do
      it 'returns 422' do
        post '/categories', params: { category: { category_name: '' } }
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors'][0]['field']).to eq 'category_name'
        expect(parsed_body['errors'][0]['detail']).to eq "can't be blank"
        expect(response.status).to eq 422
      end
    end
  end

  # =======================categories#update=======================
  describe 'PUT /categories/:id' do
    context 'Successful' do
      it 'responds to PUT' do
        put "/categories/#{category.id}", params: { category: { category_name: 'marriage' } }
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['data']['category_name']).to eq 'marriage'
        expect(response.status).to eq 201
      end
    end

    context 'Validations are failed' do
      it 'returns 422' do
        post '/categories', params: { category: { category_name: '' } }
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors'][0]['field']).to eq 'category_name'
        expect(parsed_body['errors'][0]['detail']).to eq "can't be blank"
        expect(response.status).to eq 422
      end
    end
  end

  # =======================categories#delete=======================
  describe 'DELETE /categories/:id' do
    context 'Successful' do
      it 'delete the category' do
        delete "/categories/#{category.id}'", params: { category: { category_id: category.id } }
        expect(response.status).to eq 200
      end
    end
  end
end
