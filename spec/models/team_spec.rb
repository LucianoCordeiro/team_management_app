require 'rails_helper'

RSpec.describe User, type: :model do
  let(:team_lead) { FactoryBot.create(:user) }
  let(:team) { Team.create(name: "Squad X", lead: team_lead) }

  before { Role.create(name: "Developer") }

  it "team attributes" do
    expect(team.name).to eql "Squad X"
    expect(team.lead).to eql team_lead
  end

  it "has many memberships and members" do
    member1 = FactoryBot.create(:user)
    member2 = FactoryBot.create(:user)

    Membership.create(
      team: team,
      member: member1
    )

    Membership.create(
      team: team,
      member: member2
    )

    expect(team.memberships.count).to eql 2
    expect(team.members.count).to eql 2

    expect(team.members.pluck(:id)).to match [member1.id, member2.id]
  end
end
