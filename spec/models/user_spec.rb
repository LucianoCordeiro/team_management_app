require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    user = User.create(
      first_name: "Mike",
      last_name: "Johnson",
      display_name: "mike_johnson",
      avatar_url: "http://image.com.br",
      location: "Regensburg"
    )
  end

  it "user attributes" do
    expect(user).to be_persisted
    expect(user.first_name).to eql "Mike"
    expect(user.last_name).to eql "Johnson"
    expect(user.display_name).to eql "mike_johnson"
    expect(user.avatar_url).to eql "http://image.com.br"
    expect(user.location).to eql "Regensburg"
  end

  it "has many memberships" do
    team1 = FactoryBot.create(:team)
    team2 = FactoryBot.create(:team)

    membership1 = user.memberships.create(
      team: team1
    )

    membership2 = user.memberships.create(
      team: team2
    )

    expect(user.memberships.count).to eql 2
    expect(user.memberships.pluck(:id)).to match [membership1.id, membership2.id]
  end
end
