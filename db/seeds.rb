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

User.create!(
  name: "INTJ",
  mbti: "INTJ",
  email: "test1@test.com",
  is_deleted: false,
  password: "test01"
)

User.create!(
  name: "INTP",
  mbti: "INTP",
  email: "test2@test.com",
  is_deleted: false,
  password: "test02"
)

User.create!(
  name: "ENTJ",
  mbti: "ENTJ",
  email: "test3@test.com",
  is_deleted: false,
  password: "test03"
)

User.create!(
  name: "ENTP",
  mbti: "ENTP",
  email: "test4@test.com",
  is_deleted: false,
  password: "test04"
)

User.create!(
  name: "INFJ",
  mbti: "INFJ",
  email: "test5@test.com",
  is_deleted: false,
  password: "test05"
)

User.create!(
  name: "INFP",
  mbti: "INFP",
  email: "test6@test.com",
  is_deleted: false,
  password: "test06"
)

User.create!(
  name: "ENFJ",
  mbti: "ENFJ",
  email: "test7@test.com",
  is_deleted: false,
  password: "test07"
)

User.create!(
  name: "ENFP",
  mbti: "ENFP",
  email: "test8@test.com",
  is_deleted: false,
  password: "test08"
)

User.create!(
  name: "ISTJ",
  mbti: "ISTJ",
  email: "test9@test.com",
  is_deleted: false,
  password: "test09"
)

User.create!(
  name: "ISFJ",
  mbti: "ISFJ",
  email: "test10@test.com",
  is_deleted: false,
  password: "test10"
)

User.create!(
  name: "ESTJ",
  mbti: "ESTJ",
  email: "test11@test.com",
  is_deleted: false,
  password: "test11"
)

User.create!(
  name: "ESFJ",
  mbti: "ESFJ",
  email: "test12@test.com",
  is_deleted: false,
  password: "test12"
)

User.create!(
  name: "ISTP",
  mbti: "ISTP",
  email: "test13@test.com",
  is_deleted: false,
  password: "test13"
)

User.create!(
  name: "ISFP",
  mbti: "ISFP",
  email: "test14@test.com",
  is_deleted: false,
  password: "test14"
)

User.create!(
  name: "ESTP",
  mbti: "ESTP",
  email: "test15@test.com",
  is_deleted: false,
  password: "test15"
)

User.create!(
  name: "ESFP",
  mbti: "ESFP",
  email: "test16@test.com",
  is_deleted: false,
  password: "test16"
)

User.create!(
  name: "unknown",
  mbti: "unknown",
  email: "test17@test.com",
  is_deleted: false,
  password: "test17"
)

# ＝＝＝＝＝＝＝＝＝＝＝初期Tagの追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

['INTJ', 'INTP', 'ENTJ', 'ENTP', 'INFJ', 'INFP', 'ENFP', 'ISTJ', 'ISFJ', 'ESTJ', 'ESFJ', 'ISTP', 'ISFP', 'ESTP', 'ESFP', 'あるある', '恋愛', '繋がりたい', '心理機能', 'ソシオニクス', '有名人', '偏見', 'その他']
.each do |name|
  Tag.create!(
    { name: name }
    )
  end

# ＝＝＝＝＝＝＝＝＝＝＝初期Postの追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

post1 = Post.new(
  user_id: 1,
  title: "建築家",
  text: "想像力が豊かで、戦略的な思考の持ち主。あらゆる物事に対して計画を立てる。",
  tag_ids: [1, 17],
  status: 0
)
post1.images.attach(io: File.open(Rails.root.join('app/assets/images/INTJ.jpg')), filename: 'INTJ.jpg')
post1.save!

post2 = Post.new(
  user_id: 2,
  title: "論理学者",
  text: "論理学者は持ち前の“ユニークな視野”と“活発な知力”に誇りを持っていて、宇宙のあらゆる謎について色々と考えざるにはいられない人たちです。歴史上、影響力のある多くの哲学者や科学者たちの中に論理学者がいるのも納得でしょう。この性格タイプの人たちはかなりまれなのですが、独創性と創作力を備えていることもあり、周りから注目を浴びるのも恐れません。",
  tag_ids: [2, 20, 22],
  status: 1
)
post2.images.attach(io: File.open(Rails.root.join('app/assets/images/INTP.jpg')), filename: 'INTP.jpg')
post2.save!

post3 = Post.new(
  user_id: 3,
  title: "指揮官",
  text: "大胆で想像力豊か、かつ強い意志を持つ指導者。常に道を見つけるか、道を切り開く。",
  tag_ids: 3,
  status: 2
)
post3.images.attach(io: File.open(Rails.root.join('app/assets/images/ENTJ.jpg')), filename: 'ENTJ.jpg')
post3.save!

post4 = Post.new(
  user_id: 4,
  title: "討論者",
  text: "討論者は頭の回転が速い上に大胆な気質の持ち主で、迷わず現状に異議を唱えるタイプの人たちです。
  それどころか相手が誰であっても、またどんな内容であっても、反対意見を述べることに躊躇しません。
  議論することが何よりも大好きで、賛否の分かれるトピックに会話が進めば進むほど、面白いと感じるタイプです。",
  tag_ids: 4,
  status: 0
)
post4.save!

post5 = Post.new(
  user_id: 5,
  title: "提唱者",
  text: "物静かで神秘的だが、人々を非常に勇気づける飽くなき理想主義者",
  tag_ids: [5, 19],
  status: 0
)
post5.save!

