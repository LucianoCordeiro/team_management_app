class FindMembershipRole
  attr_reader :member_id, :membership_id, :error

  def initialize(member_id:, membership_id:)
    @member_id = member_id
    @membership_id = membership_id
  end

  def run
    membership_role.present? || raise_not_found
  rescue ActiveRecord::RecordNotFound => e
    @error = e.message
    false
  end

  def role_name
    @role_name ||= membership_role.name
  end

  private

  def member
    @member ||= User.find(member_id)
  end

  def membership
    @membership ||= member.memberships.find(membership_id)
  end

  def membership_role
    @membership_role ||= membership.role
  end

  def not_found
    raise(ActiveRecord::RecordNotFound.new("Role not found"))
  end
end
