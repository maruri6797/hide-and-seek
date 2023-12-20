require 'rails_helper'

RSpec.describe "[STEP1]ユーザーログイン前のテスト", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }
  let!(:tag) { create(:tag) }

  before do
    sign_in(user)
  end

  describe 'ヘッダーのテスト：ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it 'ホームを押すと、投稿一覧画面に遷移する' do
        find_all('a')[3].click
        is_expected.to eq '/posts'
      end
      it '検索を押すと、検索画面に遷移する' do
        find_all('a')[4].click
        is_expected.to eq '/search'
      end
      it 'マイページを押すと、ユーザー詳細画面に遷移する' do
        find_all('a')[5].click
        is_expected.to eq '/users/' + user.id.to_s
      end
      it '通知を押すと、通知一覧画面に遷移する' do
        find_all('a')[6].click
        is_expected.to eq '/notifications'
      end
      it 'DMを押すと、DM一覧画面に遷移する' do
        find_all('a')[7].click
        is_expected.to eq '/rooms'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
      click_link '全体'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do #必要ない可能性有
        expect(current_path).to eq '/posts'
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(post.user)
        expect(page).to have_link '', href: user_path(other_post.user)
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
        expect(page).to have_link post.title, href: post_path(post)
        expect(page).to have_link other_post.title, href: post_path(other_post)
      end
      it '自分の投稿と他人の投稿のテキストが表示される' do
        expect(page).to have_content post.text
        expect(page).to have_content other_post.text
      end
      it 'タグが表示される' do
        expect(page).to have_content tag.name
      end
    end
  end

  describe '投稿のテスト' do
    before do
      find(".expansion").click
    end

    context '表示内容の確認' do
      it '「投稿」と表示される' do
        expect(page).to have_content '投稿'
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'post[title]'
      end
      it 'titleフォームに値が入っていない' do
        expect(find_field('post[title]').text).to be_blank
      end
      it 'textフォームが表示される' do
        expect(page).to have_field 'post[text]'
      end
      it 'textフォームに値が入っていない' do
        expect(find_field('post[text]').text).to be_blank
      end
      it '画像フォームが表示される' do
        expect(page).to have_field 'post[images][]'
      end
      it 'tagフォームが表示される' do
        expect(page).to have_field 'post[tag_ids][]'
      end
      it '投稿するボタンが表示される' do
        expect(page).to have_button '投稿する'
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'post[text]', with: Faker::Lorem.characters(number: 30)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿する' }.to change(user.posts, :count).by(1)
      end
      it 'リダイレクト先が、投稿の一覧画面になっている' do
        click_button '投稿する'
        expect(current_path).to eq '/posts'
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit post_path(post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
      it 'ユーザー画像・名前のリンク先が正しい' do
        expect(page).to have_link post.user.name, href: user_path(post.user)
      end
      it '投稿のtitleが表示される' do
        expect(page).to have_content post.title
      end
      it '投稿のtextが表示される' do
        expect(page).to have_content post.text
      end
      it 'いいねリンクが表示される' do
        expect(page).to have_link "", href: post_favorites_path(post)
      end
      it 'お気に入りリンクが表示される' do
        expect(page).to have_link "", href: post_stars_path(post)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        second_user_post = FactoryBot.create(:post, user: user)
        visit post_path(second_user_post)
        find(".three-point-content").click
        click_link '編集する'
        expect(current_path).to eq edit_post_path(second_user_post)
      end
    end

    context '削除リンクのテスト' do
      it '正しく削除される：リダイレクト先が、投稿一覧画面になっている' do
        second_user_post = FactoryBot.create(:post, user: user)
        visit post_path(second_user_post)
        find(".three-point-content").click
        click_link '削除する'
        expect(page).to_not have_content second_user_post.title
        expect(current_path).to eq '/posts'
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it '「投稿編集」と表示される' do
        expect(page).to have_content '投稿編集'
      end
      it 'title編集フォームが表示される' do
        expect(page).to have_field 'post[title]', with: post.title
      end
      it 'text編集フォームが表示される' do
        expect(page).to have_field 'post[text]', with: post.text
      end
      it '戻るリンクが表示される' do
        expect(page).to have_link '戻る', href: post_path(post)
      end
      it '変更して投稿するボタンが表示される' do
        expect(page).to have_button '変更して投稿する'
      end
    end

    context '編集成功のテスト' do
      before do
        @post_old_title = post.title
        @post_old_text = post.text
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 9)
        fill_in 'post[text]', with: Faker::Lorem.characters(number: 29)
        click_button '変更して投稿する'
      end

      it 'titleが正しく更新される' do
        expect(post.reload.title).not_to eq @post_old_title
      end
      it 'textが正しく更新される' do
        expect(post.reload.text).not_to eq @post_old_text
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
      it '2度目の編集はできない' do
        visit edit_post_path(post)
        expect(current_path).to eq '/posts/' + post.id.to_s
        expect(page).to have_content '編集済みのため画面遷移できません'
      end
    end
  end

  describe '自分のユーザー詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '自分の名前、mbti、自己紹介文が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content user.mbti
        expect(page).to have_content user.introduction
      end
      it '自分へのフォローリンクは表示されない' do
        expect(page).not_to have_link 'フォロー', href: user_relationships_path(user)
      end
      it '自分のユーザー編集、ログアウトへのリンクが存在する' do
        find(".three-point-contents").click
        expect(page).to have_link '編集', href: edit_user_path(user)
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      end
      it '自分の投稿数が表示される' do
        expect(page).to have_content user.posts.count
      end
      it '自分のフォロー、フォロワー数、いいね、お気に入り数が表示され、リンクが正しい' do
        expect(page).to have_link user.followers.count, href: followings_user_path(user)
        expect(page).to have_link user.followeds.count, href: followers_user_path(user)
        expect(page).to have_link user.favorites.count, href: favorites_user_path(user)
        expect(page).to have_link user.stars.count, href: stars_user_path(user)
      end
      it '投稿一覧のユーザー画像・名前のリンク先が正しい' do
        expect(page).to have_link user.name, href: user_path(user)
      end
      it '投稿一覧に自分の投稿のtitleが表示され、リンクが正しい' do
        expect(page).to have_link post.title, href: post_path(post)
      end
      it '投稿一覧に自分の投稿のtextが表示される' do
        expect(page).to have_content post.text
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: user_path(other_user)
        expect(page).not_to have_content other_post.title
        expect(page).not_to have_content other_post.text
      end
    end
  end

  describe '自分のユーザー情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '退会ボタンが表示され、リンク先が正しい' do
        expect(page).to have_link '退会', href: check_user_path(user)
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it 'ユーザー名編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it 'mbti編集フォームに自分のmbtiが表示される' do
        expect(page).to have_field 'user[mbti]', with: user.mbti
      end
      it '自己紹介編集フォームに自分の自己紹介文が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_mbti = user.mbti
        @user_old_introduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 4)
        choose 'user[mbti]', with: 'ISTP'
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        expect(user.profile_image).to be_attached
        click_button '保存'
        save_page
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'mbtiが正しく更新される' do
        expect(user.reload.mbti).not_to eq @user_old_mbti
      end
      it 'introductionが正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_introduction
      end
      it 'リダイレクト先が、自分のマイページになっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end

  describe '通報のテスト' do
    before do
      visit user_path(other_user)
      find(".three-point-contents").click
      click_link '通報する'
    end

    context '表示内容の確認' do
      it '報告が表示される' do
        expect(page).to have_content '報告'
      end
      it 'コンテンツフォームが表示される' do
        expect(page).to have_field 'report[content]'
      end
      it '理由フォームが表示される' do
        expect(page).to have_field 'report[reason]'
      end
      it '報告ボタンが表示される' do
        expect(page).to have_button '報告'
      end
    end

    context '報告成功のテスト' do
      it '報告が成功し、相手のマイページにリダイレクトされる' do
        choose "report_content_user"
        choose "report_reason_spam"
        click_button '報告'
        expect(current_path).to eq '/users/' + other_user.id.to_s
      end
    end
  end

  describe '検索画面のテスト' do
    before do
      visit search_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/search'
      end
      it '検索フォームが表示される' do
        expect(page).to have_field 'keyword'
      end
      it '投稿が表示される' do
        expect(page).to have_content post.title
        expect(page).to have_content other_post.title
      end
      it 'タグが表示される' do
        expect(page).to have_content 'タグ'
      end
    end
# send_keys使えず検索結果の確認不可
  end
end