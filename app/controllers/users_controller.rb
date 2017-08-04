class UsersController < ApplicationController
  include InheritAction

  # GET /users/:id
  def show
    json_response({
      success: true,
      data: {
        users: single_record_serializer.new(@resource, serializer: Users::UserAttributesSerializer),
      }
    }, 200)
    
  end

end