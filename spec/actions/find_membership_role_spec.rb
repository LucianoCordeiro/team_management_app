require "rails_helper"

RSpec.describe FindMembershipRole do

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

  it 'assign role to membership' do
    action = described_class.new(
      membership_id: membership.id,
      member_id: member.id
    )

    expect(action.run).to be true
    expect(action.role_name).to eql "Product Owner"
  end

  it 'membership not found' do
    action = described_class.new(
      membership_id: "23",
      member_id: member.id
    )

    expect(action.run).to be false
    expect(action.error).to eql "Couldn't find Membership with 'id'=23 [WHERE \"memberships\".\"user_id\" = $1]"
  end

  it 'member not found' do
    action = described_class.new(
      membership_id: membership.id,
      member_id: "abcd"
    )

    expect(action.run).to be false
    expect(action.error).to eql "Couldn't find User with 'id'=abcd"
  end
end
