# frozen_string_literal: true

# category controller
class CategoriesController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: [ :active ]
  include InheritAction

  # Callabcks
  before_action :fetch_category, only: [ :destroy, :update ]

  # GET   /categories
  def index
    @categories = current_resource_owner.categories
    render_success_response({ :categories => @categories },200)
  end

  # GET  /categories/active
  def active
    render_success_response({ :categories => Category.where(status: 'active') },200)
  end

  # POST /categories
  def create
    @category = Category.create!(category_params)
    render_success_response({ :category => @category}, 201)
  end

  # PATCH  /categories/:id
  def update
    @category.update_attributes!(resource_params)
    render_success_response({ :category => @category}, 201)
  end

  # DELETE /categories/:id
  def destroy
    @category.destroy!
    json_response({ :category => @category }, 200)
  end

  private

  def category_params
    params.require(:category).permit( :category_name, :status, :user_id).merge(:user_id => current_resource_owner.id)
  end

   def fetch_category
    @category = current_resource_owner.categories.find(params[:id])
  end

end
