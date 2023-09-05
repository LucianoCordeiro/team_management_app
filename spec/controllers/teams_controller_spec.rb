
require 'rails_helper'

RSpec.describe 'Team', type: :request do
  let!(:team) { FactoryBot.create(:team) }
  let!(:role) { Role.create(name: "Developer") }

  let(:member1) { FactoryBot.create(:user) }
  let(:member2) { FactoryBot.create(:user) }

  before do
    Membership.create(
      member: member1,
      team: team
    )

    Membership.create(
      member: member2,
      team: team
    )
  end

  it 'team found' do
    get(
      "/teams/#{team.id}"
    )

    expect(response.status).to eql 200
    expect(response.body).to eql(
      {
        team: {
          id: team.id,
          name: team.name,
          team_lead_id: team.lead.id,
          team_members_ids: [member1.id, member2.id]
        }
      }.to_json
    )
  end

  it 'team not found' do
    get(
      "/teams/#{SecureRandom.uuid}"
    )

    expect(response.status).to eql 404
    expect(response.body).to eql(
      {
        error: "Team not found"
      }.to_json
    )
  end

  it 'list teams' do
    get(
      "/teams"
    )

    expect(response.status).to eql 200
    expect(response.body).to eql(
      {
        teams: [
          {
            id: team.id,
            name: team.name,
            team_lead_id: team.lead.id,
            team_members_ids: [member1.id, member2.id]
          }
        ]
      }.to_json
    )
  end
end
