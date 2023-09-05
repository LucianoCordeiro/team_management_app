class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams, id: :uuid do |t|
      t.references :team_lead, type: :uuid, index: true, foreign_key: {to_table: :users}
      t.string :name
      t.timestamps
    end
  end
end
