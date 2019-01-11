# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { 'タイトル１' }
    content { 'コンテント１' }
    deadline { DateTime.new(2019, 12, 24, 0o0, 0o0, 0o0) }
    status { '着手中' }
    priority { 2 }
    association :user, factory: :user, name: 'john'
  end

  factory :second_task, class: Task do
    title { 'タイトル２' }
    content { 'コンテント２' }
    deadline { DateTime.new(2020, 12, 24, 0o0, 0o0, 0o0) }
    status { '完了' }
    priority { 1 }
    association :user, factory: :user, name: 'john'
  end

  factory :task3, class: Task do
    title { 'タイトル３' }
    content { 'コンテント３' }
    deadline { DateTime.new(2019, 12, 23, 0o0, 0o0, 0o0) }
    status { '未着手' }
    priority { 2 }
    association :user, factory: :user, name: 'john'
  end

  factory :task4, class: Task do
    title { 'タイトル４' }
    content { 'コンテント４' }
    deadline { DateTime.new(2019, 12, 22, 0o0, 0o0, 0o0) }
    status { '未着手' }
    priority { 1 }
    association :user, factory: :user, name: 'john'
  end

  factory :task5, class: Task do
    title { 'タイトル５' }
    content { 'コンテント５' }
    deadline { DateTime.new(2019, 12, 21, 0o0, 0o0, 0o0) }
    status { '着手中' }
    priority { 0 }
    association :user, factory: :user, name: 'john'
  end

  factory :not_johns_task, class: Task do
    title { 'タイトル６' }
    content { 'コンテント６' }
    deadline { DateTime.new(2019, 12, 23, 0o0, 0o0, 0o0) }
    status { '着手中' }
    priority { 0 }
  end
end
