# frozen_string_literal: true

FactoryBot.define do
  factory :task_label_relation do
    task_id { 1 }
    label_id { 1 }
  end
end
