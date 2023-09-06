class Membership < ApplicationRecord
  belongs_to :member, foreign_key: :user_id, class_name: 'User'
  belongs_to :team
  belongs_to :role, optional: true

  validates_uniqueness_of :team_id, scope: :user_id

  before_validation :set_default_role, on: :create, if: -> { self.role.blank? }

  def set_default_role
    self.role = Role.find_by(name: "Developer")
  end
end
