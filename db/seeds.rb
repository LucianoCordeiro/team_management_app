Role.find_or_create_by(
  name: "Developer"
)

Role.find_or_create_by(
  name: "Tester"
)

Role.find_or_create_by(
  name: "Product Owner"
)

ActiveRecord::Base.transaction do
  conn = Faraday.new(
    url: "https://cgjresszgg.execute-api.eu-west-1.amazonaws.com"
  )

  users_response = conn.get("/users")
  users = JSON.parse(users_response.body)

  users.each do |u|
    user_response = conn.get("/users/#{u["id"]}")
    user_body = JSON.parse(user_response.body)

    user = User.find_or_initialize_by(id: user_body["id"])

    user.update(
      first_name: user_body["firstName"],
      last_name: user_body["lastName"],
      display_name: user_body["displayName"],
      avatar_url: user_body["avatarUrl"],
      location: user_body["location"]
    )
  end

  teams_response = conn.get("/teams")
  teams = JSON.parse(teams_response.body)

  teams.each do |t|
    team_response = conn.get("/teams/#{t["id"]}")
    team_body = JSON.parse(team_response.body)

    team = Team.find_or_initialize_by(id: team_body["id"])

    team.update(
      name: team_body["name"],
      team_lead_id: team_body["teamLeadId"]
    )

    team_body["teamMemberIds"].each do |member_id|
      Membership.find_or_create_by(
        user_id: member_id,
        team_id: team_body["id"]
      )
    end
  end
end

puts "Users: #{User.count}"
puts "Teams: #{Team.count}"
puts "Memberships: #{Membership.count}"
puts "Roles: #{Role.count}"
