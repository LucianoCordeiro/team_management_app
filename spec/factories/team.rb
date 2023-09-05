# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    association :lead, factory: :user
    name { "Squad X" }
  end
end
