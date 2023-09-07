class TeamsController < ApplicationController
  def index
    teams = Team.all.map { |team| serialize_team(team) }

    render json: { teams: teams }, status: :ok
  end

  def show
    team = Team.find_by(id: params[:id])

    return error_response(
      message: "Team not found",
      status: :not_found
    ) unless team

    render json: { team: serialize_team(team) }, status: :ok
  end

  private

  def serialize_team(team)
    {
      id: team.id,
      name: team.name,
      team_lead_id: team.lead.id,
      team_members_ids: team.members.pluck(:id)
    }
  end
end
