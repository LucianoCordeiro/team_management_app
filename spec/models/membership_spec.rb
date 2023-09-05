require 'rails_helper'

RSpec.describe Membership, type: :model do
  let!(:role) { Role.create(name: "Tester") }
  let(:team) { FactoryBot.create(:team) }
  let(:member) { FactoryBot.create(:user) }

  it "membership attributes" do
    membership = Membership.create(
      role: role,
      team: team,
      member: member
    )

    expect(membership.role).to eql role
    expect(membership.team).to eql team
    expect(membership.member).to eql member
  end

  it "save default role when no role is given" do
    dev_role = Role.create(name: "Developer")

    membership = Membership.create(
      team: team,
      member: member
    )

    expect(membership.role).to_not eql role
    expect(membership.role).to eql dev_role
  end
end
