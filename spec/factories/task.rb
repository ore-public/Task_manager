FactoryBot.define do
  factory :task do
    title { 'タイトル１' }
    content { 'コンテント１' }
    deadline { DateTime.new(2020, 12, 24, 00, 00, 00) }
  end

  factory :second_task, class: Task do
    title { 'タイトル２' }
    content { 'コンテント２' }
    deadline { DateTime.new(2019, 12, 24, 00, 00, 00) }
  end
end
