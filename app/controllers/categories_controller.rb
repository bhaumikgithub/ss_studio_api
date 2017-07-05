class CategoriesController < ApplicationController
  include InheritAction

  def create
    @category = Category.create(category_params)
    render_success_response({ :categories => @category}, 201)
  end

  private

  def category_params
  	params.require(:categories).permit( :category_name, :status, :user_id).merge(:user_id => current_resource_owner.id)
  end

end
