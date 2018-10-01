class ProfileCompletenessesController < ApplicationController
  # GET /profile_completenesses
  def index
    @profile_completeness = current_resource_owner.profile_completeness
    json_response({
      success: true,
      data: {
        profile_completeness: single_record_serializer.new(@profile_completeness, serializer: ProfileCompletenesses::ProfileAttributesSerializer),
      }
    }, 200)
  end
end
