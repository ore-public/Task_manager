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
              priority: priority
              )
end
