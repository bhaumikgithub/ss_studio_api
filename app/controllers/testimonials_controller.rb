class TestimonialsController < ApplicationController
  include InheritAction
  include ProfileCompleteHelper
  skip_before_action :doorkeeper_authorize!, only: [ :active ]
  before_action :fetch_testimonial, only: [ :show, :update ]
  before_action :watermark_processor,only: [:create, :update]

  # GET /testimonials
  def index
    @testimonials = current_resource_owner.testimonials.page(
      params[:page]
    ).per(
      params[:per_page]
    ).order(
      "testimonials.updated_at #{params[:sorting_order]}"
    )
    json_response({
      success: true,
      data: {
        testimonials: array_serializer.new(@testimonials, serializer: Testimonials::TestimonialAttributesSerializer, style: "thumb"),
      },
      meta: meta_attributes(@testimonials)
    }, 200)
  end

  # POST /testimonials
  def create
    @testimonial = current_resource_owner.testimonials.create!(resource_params)
    if @testimonial.photo.present?
      @testimonial.photo.update_user(current_resource_owner)
    end
    if @testimonial.present? && !current_resource_owner.profile_completeness.add_testimonial
      next_task = next_task('add_testimonial')
      current_resource_owner.profile_completeness.update(add_testimonial: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
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
    @testimonials = User.get_user(params[:user]).testimonials.all.where(status: 'active')
    if params[:onlyAPI].present? && params[:onlyAPI] == "true"
      json_response({
        success: true,
        data: {
          testimonials: array_serializer.new(@testimonials, serializer: Testimonials::TestimonialAttributesSerializer, style: "medium"),
        }
      }, 200)
    else
      respond_to do |format|
        format.html
      end
    end
  end

  private

  def resource_params
    params.require(:testimonial).permit(:client_name, :message, :contact_id, :rating, :status, photo_attributes: [:id, :image, :_destroy]).merge(user_id: current_resource_owner.id)
  end

  def fetch_testimonial
    @testimonial = current_resource_owner.testimonials.find(params[:id])
  end

  def watermark_processor
    Photo.apply_watermark = false if params[:testimonial][:photo_attributes][:image].present?
  end

end
