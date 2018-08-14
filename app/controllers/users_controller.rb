class UsersController < ApplicationController
  include InheritAction
  skip_before_action :doorkeeper_authorize!, only: [ :get_countries ]

  def index
    @users = User.all.page(
        params[:page]
      ).per(
        params[:per_page]
      ).order(
        updated_at: :desc
      ).includes(
        :role
      )
    json_response({
      success: true,
      data: {
        users: array_serializer.new(@users, serializer: Users::UsersAttributesSerializer),
      },
      meta: meta_attributes(@users)
    }, 200)
  end

  # GET /users/:id
  def show
    json_response({
      success: true,
      data: {
        user: single_record_serializer.new(@resource, serializer: Users::UserAttributesSerializer),
      }
    }, 200)
    
  end

  # PATCH  /users/:id/update_password
  def update_password
    @user = User.find(params[:id])
    if @user.update_with_password(user_params.merge(validate_password: ['password', 'password_confirmation']))
      json_response({success: true,message: "Password updated successfully"},201)
    else
      render_unprocessable_entity_response(@user)
    end
  end

  def get_countries
    @countries = Country.all
    render_success_response({ :countries => @countries },200)
  end

  private

  def user_params
    params.require(:user).permit(:current_password,:password, :password_confirmation)
  end
end
