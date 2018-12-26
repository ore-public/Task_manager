# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8

50.times do |no|
  d = rand(1..29)
  m = rand(1..12)
  priority = no % 3
  num = no % 4
  if num == 0
    state = "未着手"
  elsif num == 1
    state = "着手中"
  elsif num == 2
    state = "未着手"
  else num == 3
    state = "完了"
  end

  Task.create(title: "タイトル #{no}",
              content: "内容#{no}",
              deadline: DateTime.new(2019, m, d, 00, 00, 00),
              status: state,
              priority: priority,
              user_id: 1
              )
end

User.create(name: "firstman",
            email: "aaa@dic.jp",
            password: "123456789",
            admin: true)

User.create(name: "secondman",
            email: "bbb@dic.jp",
            password: "123456789")

Label.create(name: "Life")
Label.create(name: "Work")
Label.create(name: "Programing")
Label.create(name: "Ruby")
Label.create(name: "Rails")
Label.create(name: "HTML")
Label.create(name: "CSS")
Label.create(name: "JavaScript")
Label.create(name: "Python")
Label.create(name: "PHP")

task = Task.find_by(title: "タイトル１")
label = Label.find_by(name: "Life")
TaskLabelRelation.create(task_id: task.id, label_id: label.id)
