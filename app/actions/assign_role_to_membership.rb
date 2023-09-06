class AssignRoleToMembership
  attr_reader :role_id, :member_id, :membership_id, :error

  def initialize(member_id:, membership_id:, role_id:)
    @member_id = member_id
    @membership_id = membership_id
    @role_id = role_id
  end

  def run
    membership.update!(
      role: role
    )
    true
  rescue ActiveRecord::RecordNotFound => e
    @error = e.message
    false
  end

  def membership
    @membership ||= member.memberships.find(membership_id)
  end

  private

  def member
    @member ||= User.find(member_id)
  end

  def role
    @role ||= Role.find(role_id)
  end
end
