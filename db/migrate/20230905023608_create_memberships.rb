class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.references :user, type: :uuid, index: true
      t.references :team, type: :uuid, index: true
      t.timestamps
    end
  end
end
