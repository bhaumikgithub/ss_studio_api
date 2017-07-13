# frozen_string_literal: true

# category controller
class CategoriesController < ApplicationController
  include InheritAction

  # POST /categories
  def create
    @category = Category.create!(category_params)
    render_success_response({ :categories => @category}, 201)
  end

  private

  def category_params
    params.require(:category).permit( :category_name, :status, :user_id).merge(:user_id => current_resource_owner.id)
  end

end
