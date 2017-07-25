class TestimonialsController < ApplicationController
  include InheritAction
  before_action :fetch_testimonial, only: [ :show ]
  
  def index
    @testimonials = current_resource_owner.testimonials
    json_response({
      success: true,
      data: {
        testimonials: array_serializer.new(@testimonials, serializer: Testimonials::TestimonialAttributesSerializer),
      }
    }, 200)
  end

  def create
    @testimonial = Testimonial.create!(resource_params)
    @testimonial.photo.update_user(current_resource_owner)
    render_success_response({ :testimonial => @testimonial}, 201)
  end

  def show
    json_response({
      success: true,
      data: {
        testimonials: single_record_serializer.new(@testimonial, serializer: Testimonials::TestimonialAttributesSerializer),
      }
    }, 200)
  end

  private

  def resource_params
    params.require(:testimonial).permit(:client_name, :message, :contact_id, :status, photo_attributes: [:id, :image, :_destroy]).merge(user_id: current_resource_owner.id)
  end

  def fetch_testimonial
    @testimonial = current_resource_owner.testimonials.find(params[:id])
  end

end
