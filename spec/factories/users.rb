FactoryBot.define do
  factory :user do
    name { "john" }
    email { "john@dic.jp" }
    password { "aaaaaaaaaa" }

    #
    # after(:build) do |user|
    #   user.tasks << FactoryBot.build(:task, title: "コンテント１")
    #   user.tasks << FactoryBot.build(:second_task, title: "コンテント２")
    #   user.tasks << FactoryBot.build(:task3, title: "コンテント３")
    #   user.tasks << FactoryBot.build(:task4, title: "コンテント４")
    #   user.tasks << FactoryBot.build(:task5, title: "コンテント５")
    # end

  end
end
