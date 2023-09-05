require 'rails_helper'

RSpec.describe User, type: :model do
  it "user attributes" do
    user = User.create(
      first_name: "Mike",
      last_name: "Johnson",
      display_name: "mike_johnson",
      avatar_url: "http://image.com.br",
      location: "Regensburg"
    )

    expect(user).to be_persisted
    expect(user.first_name).to eql "Mike"
    expect(user.last_name).to eql "Johnson"
    expect(user.display_name).to eql "mike_johnson"
    expect(user.avatar_url).to eql "http://image.com.br"
    expect(user.location).to eql "Regensburg"
  end
end
