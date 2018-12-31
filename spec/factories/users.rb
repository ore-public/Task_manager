# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'john' }
    email { 'john@dic.jp' }
    password { 'aaaaaaaaaa' }
    admin { true }
  end

  factory :not_john, class: User do
    name { 'not_john' }
    email { 'not_john@dic.jp' }
    password { 'bbbbbbbbbb' }
  end
end
