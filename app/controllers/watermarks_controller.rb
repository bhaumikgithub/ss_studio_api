class WatermarksController < ApplicationController
	include InheritAction

	def create
		super
		Watermark.where.not(id: @resource.id).update_all(status: 0)
	end

	private
  def resource_params
    params.require(:watermark).permit(:watermark_image, :user_id, :status ).merge(:user_id => current_resource_owner.id)
  end
end
