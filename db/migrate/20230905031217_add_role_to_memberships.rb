class AddRoleToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_reference :memberships, :role, type: :uuid, index: true
  end
end
