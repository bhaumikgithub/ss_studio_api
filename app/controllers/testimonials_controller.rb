class TestimonialsController < ApplicationController
  include InheritAction
  skip_before_action :doorkeeper_authorize!, only: [ :active ]
  before_action :fetch_testimonial, only: [ :show, :update ]

  # GET /testimonials
  def index
    @testimonials = current_resource_owner.testimonials
    json_response({
      success: true,
      data: {
        testimonials: array_serializer.new(@testimonials, serializer: Testimonials::TestimonialAttributesSerializer, style: "thumb"),
      }
    }, 200)
  end

  # POST /testimonials
  def create
    @testimonial = current_resource_owner.testimonials.create!(resource_params)
    if @testimonial.photo.present?
      @testimonial.photo.update_user(current_resource_owner)
    end
    json_response({
      success: true,
      data: {
        testimonial: single_record_serializer.new(@testimonial, serializer: Testimonials::TestimonialAttributesSerializer, style: "thumb"),
      }
    }, 201)
  end

  # PATCH  /testimonials/:id
  def update
    @testimonial.update_attributes!(resource_params)
    @testimonial.photo.update_user(current_resource_owner)
    json_response({
      success: true,
      data: {
        testimonial: single_record_serializer.new(@testimonial, serializer: Testimonials::TestimonialAttributesSerializer, style: "thumb"),
      }
    }, 201)
  end

  # GET /testimonials/:id
  def show
    json_response({
      success: true,
      data: {
        testimonials: single_record_serializer.new(@testimonial, serializer: Testimonials::TestimonialAttributesSerializer),
      }
    }, 200)
  end

  # GET /testimonials/active
  def active
    @testimonials = Testimonial.all.where(status: 'active')
    json_response({
      success: true,
      data: {
        testimonials: array_serializer.new(@testimonials, serializer: Testimonials::TestimonialAttributesSerializer, style: "medium"),
      }
    }, 200)
  end

  private

  def resource_params
    params.require(:testimonial).permit(:client_name, :message, :contact_id, :rating, :status, photo_attributes: [:id, :image, :_destroy]).merge(user_id: current_resource_owner.id)
  end

  def fetch_testimonial
    @testimonial = current_resource_owner.testimonials.find(params[:id])
  end

end
