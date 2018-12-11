FactoryBot.define do
  factory :task do
    title { 'タイトル１' }
    content { 'コンテント１' }
  end

  factory :second_task, class: Task do
    title { 'タイトル２' }
    content { 'コンテント２' }
  end
end
