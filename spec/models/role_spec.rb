require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { Role.create(name: "Tester") }
  let(:team) { FactoryBot.create(:team) }

  it "role attributes" do
    expect(role.name).to eql "Tester"
  end

  it "has many memberships and members" do
    member1 = FactoryBot.create(:user)
    member2 = FactoryBot.create(:user)

    Membership.create(
      team: team,
      member: member1,
      role: role
    )

    Membership.create(
      team: team,
      member: member2,
      role: role
    )

    expect(role.memberships.count).to eql 2
    expect(role.members.count).to eql 2

    expect(role.members.pluck(:id)).to match [member1.id, member2.id]
  end
end
