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
    params.require(:testimonial).permit(:client_name, :message, :contact_id, :status, photo_attributes: [:id, :image, :imageable_id, :imageable_type, :_destroy, :user_id]).deep_merge(user_id: current_resource_owner.id, photo_attributes: {user_id: current_resource_owner.id})
  end

  def fetch_testimonial
    @testimonial = current_resource_owner.testimonials.find(params[:id])
  end

end
