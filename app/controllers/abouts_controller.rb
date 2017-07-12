class AboutsController < ApplicationController
	include InheritAction

	private

  def resource_params
    params.require(:about).permit(:title_text, :description, :social_links=>{})
  end
end
