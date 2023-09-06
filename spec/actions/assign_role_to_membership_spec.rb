require "rails_helper"

RSpec.describe AssignRoleToMembership do

  let(:role) { Role.create(name: "Product Owner") }
  let(:team) { FactoryBot.create(:team) }
  let(:member) { FactoryBot.create(:user) }
  let!(:membership) do
    Membership.create!(
      member: member,
      team: team
    )
  end

  it 'assign role to membership' do
    expect(membership.role).to be_nil

    action = described_class.new(
      role_id: role.id,
      membership_id: membership.id,
      member_id: member.id
    )

    expect(action.run).to be true

    expect(action.membership).to eql membership
    expect(membership.reload.role).to eql role
  end

  it 'membership not found' do
    action = described_class.new(
      role_id: role.id,
      membership_id: "23",
      member_id: member.id
    )

    expect(action.run).to be false
    expect(action.error).to eql "Couldn't find Membership with 'id'=23 [WHERE \"memberships\".\"user_id\" = $1]"
  end

  it 'role not found' do
    action = described_class.new(
      role_id: "abcd",
      membership_id: membership.id,
      member_id: member.id
    )

    expect(action.run).to be false
    expect(action.error).to eql "Couldn't find Role with 'id'=abcd"
  end

  it 'member not found' do
    action = described_class.new(
      role_id: role.id,
      membership_id: membership.id,
      member_id: "defg"
    )

    expect(action.run).to be false
    expect(action.error).to eql "Couldn't find User with 'id'=defg"
  end
end
