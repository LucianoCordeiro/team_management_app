class MembershipsController < ApplicationController
  def assign_role
    action = AssignRoleToMembership.new(
      member_id: params[:user_id],
      membership_id: params[:id],
      role_id: params[:role_id]
    )

    return error_response(
      message: action.error,
      status: :not_found
    ) unless action.run

    render json: { membership: action.membership }, status: :ok
  end

  def find_role
    action = FindMembershipRole.new(
      member_id: params[:user_id],
      membership_id: params[:id]
    )

    return error_response(
      message: action.error,
      status: :not_found
    ) unless action.run

    render json: { role_name: action.role_name }, status: :ok
  end
end
