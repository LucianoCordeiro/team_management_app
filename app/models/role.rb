class Role < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :memberships
  has_many :members, through: :memberships
end
