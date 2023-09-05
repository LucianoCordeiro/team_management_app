
require 'rails_helper'

RSpec.describe 'User', type: :request do
  let!(:user) { FactoryBot.create(:user) }

  it 'user found' do
    get(
      "/users/#{user.id}"
    )

    expect(response.status).to eql 200
    expect(response.body).to eql(
      {
        user: {
          id: user.id,
          first_name: user.first_name,
          last_name: user.last_name,
          display_name: user.display_name,
          avatar_url: user.avatar_url,
          location: user.location
        }
      }.to_json
    )
  end

  it 'user not found' do
    get(
      "/users/#{SecureRandom.uuid}"
    )

    expect(response.status).to eql 404
    expect(response.body).to eql(
      {
        error: "User not found"
      }.to_json
    )
  end

  it 'list users' do
    get(
      "/users"
    )

    expect(response.status).to eql 200
    expect(response.body).to eql(
      {
        users: [
          {
            id: user.id,
            first_name: user.first_name,
            last_name: user.last_name,
            display_name: user.display_name,
            avatar_url: user.avatar_url,
            location: user.location
          }
        ]
      }.to_json
    )
  end
end
