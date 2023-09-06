class FindRoleMemberships
  attr_reader :role_id, :error

  def initialize(role_id:)
    @role_id = role_id
  end

  def run
    role.present? || raise_not_found
  rescue ActiveRecord::RecordNotFound => e
    @error = e.message
    false
  end

  def memberships
    @memberships ||= role.memberships.map do |ms|
      {
        team_name: ms.team.name,
        team_member: ms.member.display_name,
        role: ms.role.name
      }
    end
  end

  private

  def role
    @role ||= Role.find_by(id: role_id)
  end

  def raise_not_found
    raise(ActiveRecord::RecordNotFound.new("Role not found"))
  end
end
