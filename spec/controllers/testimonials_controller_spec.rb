require 'rails_helper'

RSpec.describe TestimonialsController, type: :request do
  let(:testimonial) { FactoryGirl.create(:testimonial) }
  before do
    @user = FactoryGirl.create(:user)
    @contact = FactoryGirl.create (:contact)
    @photo = FactoryGirl.create(:photo, image: File.new(Rails.root + 'public/watermark.png'), user_id: @user.id)
    @testimonial = FactoryGirl.create(:testimonial, user: @user, contact: @contact, photo: @photo)
    @header = { Authorization: "bearer " + token_generator(@user) }
  end

  # =======================testimonials#index=======================
  describe 'GET /testimonials' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get '/testimonials'
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns all testimonials' do
          get '/testimonials', headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================testimonials#show=======================
  describe 'GET /testimonials/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        get "/testimonials/#{@testimonial.id}"
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'returns particular testimonial with associated client_name' do
          get "/testimonials/#{@testimonial.id}", headers: @header
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================testimonials#create=======================
  describe 'POST /testimonials' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        post '/testimonials', params: { testimonial: { client_name: 'hello', photo_attributes: { image: Rack::Test::UploadedFile.new('public/download.jpg') } } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'create testimonials' do
          post '/testimonials', params: { testimonial: { client_name: 'hello', photo_attributes: { image: Rack::Test::UploadedFile.new('public/download.jpg') } } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================testimonials#update=======================
  describe 'PUT /testimonials/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        put "/testimonials/#{@testimonial.id}", params: { testimonial: { client_name: 'hello', photo_attributes: { image: Rack::Test::UploadedFile.new('public/download.jpg'), id: @testimonial.photo.id } } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'responds to PUT' do
          put "/testimonials/#{@testimonial.id}", params: { testimonial: { client_name: 'hello', photo_attributes: { image: Rack::Test::UploadedFile.new('public/download.jpg'), id: @testimonial.photo.id } } }, headers: @header
          expect(response.status).to eq 201
        end
      end
    end
  end

  # =======================testimonials#delete=======================
  describe 'DELETE /testimonials/:id' do
    describe 'unauthorized' do
      it "should return unauthorized" do
        delete "/testimonials/#{@testimonial.id}", params: { testimonial: { testimonial_id: @testimonial.id } }
        assert_response :unauthorized
      end
    end

    describe 'authorized' do
      context 'Successful' do
        it 'delete the testimonial' do
          delete "/testimonials/#{@testimonial.id}", params: { testimonial: { testimonial_id: @testimonial.id } }, headers: @header
          # puts "=============#{response.body.inspect}============"
          expect(response.status).to eq 200
        end
      end
    end
  end

  # =======================testimonials#active=======================
  describe 'GET /testimonials/active' do
    context 'Successful' do
        it 'returns active testimonial' do
          get "/testimonials/active"
          expect(response.status).to eq 200
        end
      end
  end
end
