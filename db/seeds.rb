# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ＝＝＝＝＝＝＝＝＝＝＝Admin情報の追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

Admin.create!(
  email: 'admin@example.com',
  password: '000000'
  )

# ＝＝＝＝＝＝＝＝＝＝＝初期Userの追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

10.times do |n|
  User.create!(
    name: "#{n + 1}郎",
    mbti: [User.mbtis].sample,
    email: "test#{n + 1}@test.com",
    is_deleted: false,
    password: "password"
    )
end

# ＝＝＝＝＝＝＝＝＝＝＝初期Tagの追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

['User.mbtis', 'あるある', '恋愛', '繋がりたい', '心理機能', 'ソシオニクス', '有名人', 'その他']
.each do |name|
  Tag.create!(
    { name: name }
    )
  end

# ＝＝＝＝＝＝＝＝＝＝＝初期Postの追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

