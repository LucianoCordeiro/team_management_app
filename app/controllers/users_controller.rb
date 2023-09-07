class UsersController < ApplicationController
  def index
    users = User.all.map { |user| serialize_user(user) }

    render json: { users: users }, status: :ok
  end

  def show
    user = User.find_by(id: params[:id])

    return error_response(
      message: "User not found",
      status: :not_found
    ) unless user

    render json: { user: serialize_user(user) }, status: :ok
  end

  private

  def serialize_user(user)
    {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      display_name: user.display_name,
      avatar_url: user.avatar_url,
      location: user.location
    }
  end
end
