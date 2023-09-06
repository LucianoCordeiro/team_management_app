require "rails_helper"

RSpec.describe FindRoleMemberships do

  let(:role) { Role.create(name: "Product Owner") }
  let(:team) { FactoryBot.create(:team) }
  let(:member) { FactoryBot.create(:user) }
  let!(:membership) do
    Membership.create!(
      member: member,
      team: team,
      role: role
    )
  end

  it 'list memberships' do

    action = described_class.new(role_id: role.id)

    expect(action.run).to be true

    expect(action.memberships).to eql(
      [
        {
          team_name: team.name,
          team_member: member.display_name,
          role: role.name
        }
      ]
    )
  end

  it 'role not found' do
    action = described_class.new(role_id: "73000")

    expect(action.run).to be false

    expect(action.error).to eql "Role not found"
  end
end
