class UsersController < ApplicationController
  include InheritAction
  skip_before_action :doorkeeper_authorize!, only: [ :get_countries ]

  # GET  /users
  def index
    if params[:role] == "super_admin"
      @users = User.all.page(
          params[:page]
        ).per(
          params[:per_page]
        ).order(
          created_at: :desc
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
    else
      json_response({success: false, message: "You are not authorized.", errors: 'You are not authorized'}, 401)
    end
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

  # PATCH  /users/:id
  def update
    @resource.update_attributes!(resource_params)
    if params[:user][:status] == "active" && @resource.status == "active"
      @resource.confirm
    end
    json_response({
      success: true,
      data: {
        user: single_record_serializer.new(@resource, serializer: Users::UserAttributesSerializer),
      }
    }, 201)

  end

  # DELETE  /users/:id
  def destroy
    @resource.destroy!
    json_response({success: true, message: "user destroy successfully.", data: { :users => @resource }}, 200)
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

  # GET   /users/get_countries
  def get_countries
    @countries = Country.all
    render_success_response({ :countries => @countries },200)
  end

  # GET   /users/get_roles
  def get_roles
    @roles = Role.all
    render_success_response({ :roles => @roles },200)
  end

  # GET  /users/get_packages
  def get_packages
    @packages = Package.all
    render_success_response({ :packages => @packages },200)
  end

  # GET   /users/get_statuses
  def get_statuses
    statuses = User.statuses.map{|k,v| {name: k}}
    render_success_response({ :statuses => statuses },200)
  end

  def get_user_packages
    @package_users = current_resource_owner.package_users
    json_response({
      success: true,
      data: {
        users: array_serializer.new(@package_users, serializer: Users::UserPackagesAttributeSerializer),
      }
    }, 200)
  end

  # GET  /users/filter_user
  def filter_user
    users = User.where(nil)
    filtering_params(params).each do |key, value|
      users = users.public_send(key, value) if value.present?
    end
    @users = users.page(params[:page]).per(params[:per_page]).order(created_at: :desc).includes(:role) 
    json_response({
      success: true,
      data: {
        users: array_serializer.new(@users, serializer: Users::UsersAttributesSerializer),
      },
      meta: meta_attributes(@users)
    }, 200)
  end

  # GET  /users/get_user_type
  def get_user_type
    user_types = User.user_types.map{|k,v| {name: k}}
    render_success_response({ :user_types => user_types },200)
  end

  private

  def user_params
    params.require(:user).permit(:current_password,:password, :password_confirmation)
  end

  def filtering_params(params)
    params.slice(:status, :user_type, :plan)
  end
end
