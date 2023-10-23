# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ＝＝＝＝＝＝＝＝＝＝＝Admin情報の追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

admin = Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

# ＝＝＝＝＝＝＝＝＝＝＝初期Userの追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

user1 = User.find_or_create_by!(email: "test1@test.com") do |user|
  user.name = "INTJ"
  user.mbti = "INTJ"
  user.introduction = "興味があることは調べつくさないと落ち着かないです。"
  user.is_deleted = false
  user.is_license = false
  user.password = "test01"
end

user2 = User.find_or_create_by!(email: "test2@test.com") do |user|
  user.name = "INTP"
  user.mbti = "INTP"
  user.is_deleted = true
  user.is_license = false
  user.password = "test02"
end

user3 = User.find_or_create_by!(email: "test3@test.com") do |user|
  user.name = "ENTJ"
  user.mbti = "ENTJ"
  user.introduction = "私しか勝たん"
  user.is_deleted = false
  user.is_license = false
  user.password = "test03"
end

user4 = User.find_or_create_by!(email: "test4@test.com") do |user|
  user.name = "ENTP"
  user.mbti = "ENTP"
  user.is_deleted = false
  user.is_license = false
  user.password = "test04"
end

user5 = User.find_or_create_by!(email: "test5@test.com") do |user|
  user.name = "INFJ"
  user.mbti = "INFJ"
  user.is_deleted = false
  user.is_license = true
  user.password = "test05"
end

user6 = User.find_or_create_by!(email: "test6@test.com") do |user|
  user.name = "INFP"
  user.mbti = "INFP"
  user.introduction = "すぐに病むので優しくしてください"
  user.is_deleted = false
  user.is_license = false
  user.password = "test06"
end

user7 = User.find_or_create_by!(email: "test7@test.com") do |user|
  user.name = "ENFJ"
  user.mbti = "ENFJ"
  user.introduction = "みんな幸せが一番！"
  user.is_deleted = false
  user.is_license = false
  user.password = "test07"
end

user8 = User.find_or_create_by!(email: "test8@test.com") do |user|
  user.name = "ENFP"
  user.mbti = "ENFP"
  user.is_deleted = false
  user.is_license = false
  user.password = "test08"
end

user9 = User.find_or_create_by!(email: "test9@test.com") do |user|
  user.name = "ISTJ"
  user.mbti = "ISTJ"
  user.introduction = "私が真面目？君たちが不真面目なだけです。"
  user.is_deleted = false
  user.is_license = false
  user.password = "test09"
end

user10 = User.find_or_create_by!(email: "test10@test.com") do |user|
  user.name = "ISFJ"
  user.mbti = "ISFJ"
  user.is_deleted = false
  user.is_license = false
  user.password = "test10"
end

user11 = User.find_or_create_by!(email: "test11@test.com") do |user|
  user.name = "ESTJ"
  user.mbti = "ESTJ"
  user.is_deleted = false
  user.is_license = false
  user.password = "test11"
end

user12 = User.find_or_create_by!(email: "test12@test.com") do |user|
  user.name = "ESFJ"
  user.mbti = "ESFJ"
  user.introduction = "大丈夫？何かあった？"
  user.is_deleted = false
  user.is_license = true
  user.password = "test12"
end

user13 = User.find_or_create_by!(email: "test13@test.com") do |user|
  user.name = "ISTP"
  user.mbti = "ISTP"
  user.introduction = "群れる必要ある？"
  user.is_deleted = false
  user.is_license = false
  user.password = "test13"
end

user14 = User.find_or_create_by!(email: "test14@test.com") do |user|
  user.name = "ISFP"
  user.mbti = "ISFP"
  user.is_deleted = false
  user.is_license = false
  user.password = "test14"
end

user15 = User.find_or_create_by!(email: "test15@test.com") do |user|
  user.name = "ESTP"
  user.mbti = "ESTP"
  user.is_deleted = false
  user.is_license = false
  user.password = "test15"
end

user16 = User.find_or_create_by!(email: "test16@test.com") do |user|
  user.name = "ESFP"
  user.mbti = "ESFP"
  user.introduction = "楽しいことが大大大好き！"
  user.is_deleted = false
  user.is_license = false
  user.password = "test16"
end

user17 = User.find_or_create_by!(email: "test17@test.com") do |user|
  user.name = "unknown"
  user.mbti = "unknown"
  user.is_deleted = false
  user.is_license = false
  user.password = "test17"
end

# ＝＝＝＝＝＝＝＝＝＝＝初期Tagの追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

['INTJ', 'INTP', 'ENTJ', 'ENTP', 'INFJ', 'INFP', 'ENFJ', 'ENFP', 'ISTJ', 'ISFJ', 'ESTJ', 'ESFJ', 'ISTP', 'ISFP', 'ESTP', 'ESFP', 'あるある', '恋愛', '繋がりたい', '心理機能', 'ソシオニクス', '有名人', '偏見', 'その他']
.each do |name|
  Tag.create!(
    { name: name }
    )
  end

# ＝＝＝＝＝＝＝＝＝＝＝初期Postの追加＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

post1 = Post.find_or_create_by!(title: "建築家") do |post|
  post.images = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/INTJ.jpg')), filename: 'INTJ.jpg')
  post.user_id = 1
  post.text = "想像力が豊かで、戦略的な思考の持ち主。あらゆる物事に対して計画を立てる。"
  post.tag_ids = [1,17]
  post.status = 1
end

post2 = Post.find_or_create_by!(title: "論理学者") do |post|
  post.images = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/INTP.jpg')), filename: 'INTP.jpg')
  post.user_id = 2
  post.text = "論理学者は持ち前の“ユニークな視野”と“活発な知力”に誇りを持っていて、宇宙のあらゆる謎について色々と考えざるにはいられない人たちです。歴史上、影響力のある多くの哲学者や科学者たちの中に論理学者がいるのも納得でしょう。この性格タイプの人たちはかなりまれなのですが、独創性と創作力を備えていることもあり、周りから注目を浴びるのも恐れません。"
  post.tag_ids = 2
  post.status = 2
end

post3 = Post.find_or_create_by!(title: "指揮官") do |post|
  post.images = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/ENTJ.jpg')), filename: 'ENTJ.jpg')
  post.user_id = 3
  post.text = "大胆で想像力豊か、かつ強い意志を持つ指導者。常に道を見つけるか、道を切り開く。"
  post.tag_ids = [3, 17, 20]
  post.status = 2
end

post4 = Post.find_or_create_by!(title: "討論者") do |post|
  post.user_id = 4
  post.text = "討論者は頭の回転が速い上に大胆な気質の持ち主で、迷わず現状に異議を唱えるタイプの人たちです。
  それどころか相手が誰であっても、またどんな内容であっても、反対意見を述べることに躊躇しません。
  議論することが何よりも大好きで、賛否の分かれるトピックに会話が進めば進むほど、面白いと感じるタイプです。"
  post.tag_ids = [4, 21]
  post.status = 0
end

post5 = Post.find_or_create_by!(title: "提唱者") do |post|
  post.user_id = 5
  post.text = "物静かで神秘的だが、人々を非常に勇気づける飽くなき理想主義者"
  post.tag_ids = [5, 19]
  post.status = 0
end

post6 = Post.find_or_create_by!(title: "仲介者") do |post|
  post.images = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/INFP.jpg')), filename: 'INFP.jpg')
  post.user_id = 6
  post.text = "仲介者は人間性の深みについて心の底から興味があります。根っから内省的な上に、自分の思考と感情をものすごく的確に把握できる人たちで、周囲の人についても理解を深めたいと強く望みます。断定的判断を避ける気質があり、また、慈悲深い性分の持ち主で、どんな時でも他の人の話に耳を傾けるでしょう。「仲介者になぐさめてほしい」と誰かが思っていたり、誰かに心を打ち明けられたりしたら、相手の話を聞き、力になれることを光栄に感じるでしょう。"
  post.tag_ids = 6
  post.status = 1
end

post7 = Post.find_or_create_by!(title: "主人公") do |post|
  post.user_id = 7
  post.text = "カリスマ性があり、人々を励ますリーダー。聞く人を魅了する。"
  post.tag_ids = [7, 18]
  post.status = 0
end

post8 = Post.find_or_create_by!(title: "運動家") do |post|
  post.images = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/ENFP.jpg')), filename: 'ENFP.jpg')
  post.user_id = 8
  post.text = "情熱的で独創力があり、かつ社交的な自由人。常に笑いほほ笑みの種を見つけられる。"
  post.tag_ids = [8, 17, 21]
  post.status = 0
end

post9 = Post.find_or_create_by!(title: "管理者") do |post|
  post.user_id = 9
  post.text = "ロジスティシャンのひたむきさは素晴らしく、この気質のおかげで多くのことを達成できるのですが、他の人に利用されて、せっかくの強みが弱みになってしまうこともあります。
  勤労意欲が高く、義務感も強い人たちなので、日常的に他の人の責務を引き受けてしまうこともあるでしょう。
  ロジスティシャン自身はそのような状況に不満をこぼしていなくても、同僚、友人、または愛する人たちの分まで頑張るよういつも期待される（または自ら進んで引き受ける）と、やる気を失ってしまったり、疲れ切ってしまったりすることもあります。"
  post.tag_ids = 9
  post.status = 1
end

post10 = Post.find_or_create_by!(title: "擁護者") do |post|
  post.images = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/ISFJ.jpg')), filename: 'ISFJ.jpg')
  post.user_id = 10
  post.text = "非常に有能で実行力があり、多才な上に、繊細で思いやり深い面もあり、同時に分析能力が高く、細かいことにもよく気づくタイプでもあります。控えめな気質ですが人付き合いも得意なので、人間関係も安定しているでしょう。擁護者はさまざまな素晴らしい特徴を持つ人たちで、日常の他愛無い場面でも持ち前の強みを発揮する傾向にあります。"
  post.tag_ids = [10, 22]
  post.status = 0
end

post11 = Post.find_or_create_by!(title: "幹部") do |post|
  post.user_id = 11
  post.text = "優秀な管理者で、物事や人々を管理する能力にかけては、右に出る者はいない。"
  post.tag_ids = 11
  post.status = 0
end

post12 = Post.find_or_create_by!(title: "領事") do |post|
  post.user_id = 12
  post.text = "非常に思いやりがあり社交的で、人気がある。常に熱心に人々に手を差し伸べている。"
  post.tag_ids = 12
  post.status = 0
end

post13 = Post.find_or_create_by!(title: "巨匠") do |post|
  post.images = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/ISTP.jpg')), filename: 'ISTP.jpg')
  post.user_id = 13
  post.text = "大胆で実践的な思考を持つ実験者。あらゆる道具を使いこなす。"
  post.tag_ids = 13
  post.status = 0
end

post14 = Post.find_or_create_by!(title: "冒険家") do |post|
  post.images = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/ISFP.jpg')), filename: 'ISFP.jpg')
  post.user_id = 14
  post.text = "柔軟性と魅力がある芸術家。常に進んで物事を探索し経験しようとする。"
  post.tag_ids = [14, 17]
  post.status = 1
end

post15 = Post.find_or_create_by!(title: "起業家") do |post|
  post.user_id = 15
  post.text = "危険な行為をするのが自分のライフスタイル——数ある性格タイプの中でもこのようなライフスタイルを楽しむ可能性が最も高いのは起業家です。まるで台風の目のように“今この瞬間”を生きて、すぐさま行動を起こす…。修羅場・情熱・快楽を好む人たちですが、精神的なスリルではなく、持ち前の論理的な頭脳への刺激を求めています。刺激反応を合理的かつ矢継ぎ早に処理しながら、現実と事実に基づいて重要な決断を下さなければいけない——そんな状況が好きなのです。"
  post.tag_ids = [15, 19]
  post.status = 0
end

post16 = Post.find_or_create_by!(title: "エンターテイナー") do |post|
  post.user_id = 16
  post.text = "「何か新鮮で楽しいことを試したい」と思っている人を必要としている場面、または“笑い”や“遊び心”が求められている場面では、いつもエンターテイナーは歓迎されます。
  しかも、周りの人を巻き込んで何かをするのは、エンターテイナーが大好きなことです。当初の話す予定だったテーマ以外のことについて誰かと何時間も話し込んだり、愛する人のあらゆる感情に共感したり——。
  そんなことができる人たちです。
  エンターテイナー自身が将来に向けてしっかりと準備を整えることさえできれば、ワクワクするような新しいことに喜んでいつでも友人を連れて飛び込んで行くでしょう。。"
  post.tag_ids = [16, 19, 22]
  post.status = 0
end

post17 = Post.find_or_create_by!(title: "不明") do |post|
  post.user_id = 17
  post.text = "自分のMBTIが迷走しています助けてください。"
  post.tag_ids = 20
  post.status = 0
end

# フォロー関係
user1.followers << user4
user1.followers << user5
user1.followers << user7
user1.followers << user12
user1.followers << user14
user1.save

user3.followers << user5
user3.followers << user7
user3.followers << user10
user3.followers << user14
user3.followers << user16
user3.save

user4.followers << user1
user4.followers << user9
user4.followers << user12
user4.followers << user13
user4.followers << user14
user4.followers << user15
user4.save

user5.followers << user1
user5.followers << user3
user5.followers << user8
user5.followers << user11
user5.followers << user13
user5.save

user6.followers << user7
user6.followers << user9
user6.followers << user14
user6.followers << user15
user6.followers << user16
user6.save

user7.followers << user1
user7.followers << user3
user7.followers << user6
user7.followers << user9
user7.followers << user15
user7.save

user8.followers << user5
user8.followers << user11
user8.followers << user13
user8.followers << user14
user8.followers << user16
user8.save

user9.followers << user6
user9.followers << user7
user9.followers << user10
user9.followers << user12
user9.followers << user15
user9.save

user10.followers << user3
user10.followers << user4
user10.followers << user9
user10.followers << user11
user10.followers << user16
user10.save

user11.followers << user5
user11.followers << user8
user11.followers << user10
user11.followers << user12
user11.followers << user13
user11.save

user12.followers << user1
user12.followers << user4
user12.followers << user9
user12.followers << user11
user12.followers << user14
user12.save

user13.followers << user4
user13.followers << user5
user13.followers << user7
user13.followers << user8
user13.followers << user11
user13.save

user14.followers << user1
user14.followers << user4
user14.followers << user6
user14.followers << user8
user14.followers << user12
user14.save

user15.followers << user4
user15.followers << user5
user15.followers << user6
user15.followers << user7
user15.followers << user9
user15.save

user16.followers << user1
user16.followers << user3
user16.followers << user6
user16.followers << user8
user16.followers << user10
user16.save

users = User.all
posts = Post.all

users.each do |user|
  favorite_posts = posts.sample(rand(1..10))
  favorite_posts.each do |favorite_post|
    Favorite.find_or_create_by!(
      user_id: user.id,
      post_id: favorite_post.id
    )
  end
end

users.each do |user|
  star_posts = posts.sample(rand(1..10))
  star_posts.each do |star_post|
    Star.find_or_create_by!(
      user_id: user.id,
      post_id: star_post.id
    )
  end
end

user_comments = [
  '流石です！',
  '面白いですね',
  '興味深いです',
  '私もそう思います',
  'すごい！！',
  '参考になります'
]

users.each do |user|
  posts.each do |post|
    num_comments = rand(0..1)
    next if num_comments.zero?

    comment_text = user_comments.sample
    comment = PostComment.find_or_create_by!(
      user_id: user.id,
      post_id: post.id
    ) do |c|
      c.comment = comment_text
    end
  end
end