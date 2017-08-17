# frozen_string_literal: true

# category controller
class CategoriesController < ApplicationController
  include InheritAction

  # Callabcks
  before_action :fetch_category, only: [ :destroy, :update ]

  # GET   /categories
  def index
    @categories = current_resource_owner.category
    render_success_response({ :categories => @categories },200)
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
    @category = current_resource_owner.category.find(params[:id])
  end

end
