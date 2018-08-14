module CustomTokenResponse
  def body
    user_details = User.find(@token.resource_owner_id).as_json
    role = Role.find_by(id: user_details["role_id"])&.name
    # { token: super, user: user_details }
    { 
      success: true,
      message: "",
      data: {
        token: super,
        user: user_details,
        role: role
      },
      meta: [],
      errors: []
    }
  end
end