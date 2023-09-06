class RolesController < ApplicationController
  def create
    action = CreateRole.new(
      name: params[:name]
    )

    return error_response(
      message: action.error,
      status: :bad_request
    ) unless action.run

     render json: { role: action.role }, status: :ok
  end

  def memberships
    action = FindRoleMemberships.new(
      role_id: params[:id]
    )

    return error_response(
      message: action.error,
      status: :not_found
    ) unless action.run

    render json: { memberships: action.memberships }, status: :ok
  end
end
