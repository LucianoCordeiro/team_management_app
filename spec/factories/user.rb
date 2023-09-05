# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { SecureRandom.uuid }
    first_name { "Mike" }
    last_name { "Johnson" }
    display_name { "mike_johnson" }
    avatar_url { "http://image.com.br" }
    location { "Regensburg" }
  end
end
