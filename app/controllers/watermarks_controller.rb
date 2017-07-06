class WatermarksController < ApplicationController
	include InheritAction

	def create
		super
		Watermark.where("user_id=(?) and id not IN(?)",current_resource_owner.id,@resource.id).update_all(status: 0)
	end

	private
  def resource_params
    params.require(:watermark).permit(:watermark_image, :user_id, :status ).merge(:user_id => current_resource_owner.id)
  end
end
