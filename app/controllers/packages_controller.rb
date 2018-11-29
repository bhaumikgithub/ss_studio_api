class PackagesController < ApplicationController
	include InheritAction
	def index
		@packages = Package.page(
        params[:page]
      ).per(
        params[:per_page]
      ).order(
        id: :desc
      )

    json_response({
      success: true,
      data: {
        packages: array_serializer.new(@packages, serializer: Packages::PackageAttributesSerializer),
      },
      meta: meta_attributes(@packages)
    }, 200)
	end
end
