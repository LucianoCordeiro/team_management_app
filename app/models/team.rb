class Team < ApplicationRecord
  belongs_to :lead, class_name: 'User', foreign_key: :team_lead_id
  has_many :memberships
  has_many :members, through: :memberships
end
