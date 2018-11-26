class ContactDetailsController < ApplicationController
  include ProfileCompleteHelper
  skip_before_action :doorkeeper_authorize!, only: [ :contact_detail ]
  before_action :fetch_contact_detail, only: [ :show, :update ]

  # GET /contact_details
  def show
    render_success_response({ :contact_detail => @contact_detail}, 200)
  end

  #PUT /contact_details
  def update
    @contact_detail.update_attributes!(contact_detail_param)
    if @contact_detail.present? && !current_resource_owner.profile_completeness.contact_us
      next_task = next_task('contact_us')
      current_resource_owner.profile_completeness.update(contact_us: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    render_success_response({ :contact_detail => @contact_detail}, 201)
  end

  # GET /contact_detail
  def contact_detail
    render_success_response({ :contact_detail => User.get_user(params[:user]).contact_detail}, 200)
  end

  # Post /contact_details
  def create
    @contact_detail = current_resource_owner.create_contact_detail(contact_detail_param)
    if @contact_detail.present? && !current_resource_owner.profile_completeness.contact_us
      next_task = next_task('contact_us')
      current_resource_owner.profile_completeness.update(contact_us: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    render_success_response({ :contact_detail => @contact_detail}, 201)
  end

  private

  def contact_detail_param
    params.require(:contact_detail).permit(:address, :email, :phone)
  end

  def fetch_contact_detail
    @contact_detail = current_resource_owner.contact_detail
  end
end
