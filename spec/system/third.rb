require 'rails_helper'

RSpec.describe "[STEP3] 仕上げのテスト", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it 'ユーザー新規登録成功時' do
      visit new_user_registration_path
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 4)
      choose 'user[mbti]', with: 'INTJ'
      fill_in 'user[email]', with: 'a' + user.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規会員登録'
      is_expected.to have_content 'アカウント'
    end
    it 'ユーザーログイン成功時' do
      sign_in(user)
      is_expected.to have_content 'ログイン'
    end
    it 'ユーザーログアウト成功時' do
      sign_in(user)
      visit user_path(user)
      find(".three-point-contents").click
      click_link 'ログアウト'
      is_expected.to have_content 'ログアウト'
    end
    it 'ユーザーのプロフィール情報更新成功時' do
      sign_in(user)
      visit edit_user_path(user)
      click_button '保存'
      is_expected.to have_content '編集しました'
    end
    it '投稿データの新規登録成功時' do
      sign_in(user)
      find(".expansion").click
      fill_in 'post[title]', with: Faker::Lorem.characters(number: 10)
      fill_in 'post[text]', with: Faker::Lorem.characters(number: 30)
      click_button '投稿する'
      is_expected.to have_content '投稿'
    end
  end

  describe '処理失敗のテスト' do
    context 'ユーザー新規登録失敗：nameを0文字にする' do
      before do
        visit new_user_registration_path
        @name = ''
        @mbti = 'INTP'
        @email = 'a' + user.email
        fill_in 'user[name]', with: @name
        choose 'user[mbti]', with: @mbti
        fill_in 'user[email]', with: @email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '新規会員登録されない' do
        expect { click_button '新規会員登録' }.not_to change(User.all, :count)
      end
      it '新規会員登録画面を表示しており、フォームの内容が正しい' do
        click_button '新規会員登録'
        expect(page).to have_content '新規会員登録'
        expect(page).to have_field 'user[name]', with: @name
        expect(page).to have_field 'user[mbti]', with: @mbti
        expect(page).to have_field 'user[email]', with: @email
      end
      it 'バリデーションエラーが表示される' do
        click_button '新規会員登録'
        expect(page).to have_content "1文字以上で入力して下さい"
      end
    end

    context 'ユーザーのプロフィール情報編集失敗: nameを0文字にする' do
      before do
        @user_old_name = user.name
        @name = ''
        sign_in(user)
        visit edit_user_path(user)
        fill_in 'user[name]', with: @name
        click_button '保存'
      end

      it '更新されない' do
        expect(user.reload.name).to eq @user_old_name
      end
      it 'ユーザー編集画面を表示しており、フォームの内容が正しい' do
        expect(page).to have_field 'user[name]', with: @name
      end
      it 'バリデーションエラーが表示される' do
        expect(page).to have_content "1文字以上で入力して下さい"
      end
    end

    context '登録データの新規投稿失敗：titleを空にする' do
      before do
        sign_in(user)
        find(".expansion").click
        @text = Faker::Lorem.characters(number: 29)
        fill_in 'post[text]', with: @text
      end

      it '投稿が保存されない' do
        expect { click_button '投稿する' }.not_to change(Post.all, :count)
      end
    end

    context '投稿データの更新失敗: titleを空にする' do
      before do
        sign_in(user)
        visit edit_post_path(post)
        @title = ''
        @post_old_title = post.title
        fill_in 'post[title]', with: @title
        click_button '変更して投稿する'
      end

      it '投稿が更新されない' do
        expect(post.reload.title).to eq @post_old_title
      end
      it '投稿編集画面を表示しており、フォームの内容が正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s
        expect(find_field('post[title]').text).to be_blank
        expect(page).to have_field 'post[text]', with: post.text
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_content '必須項目です'
      end
    end
  end

  describe 'ログインしていない場合のアクセス制限のテスト: アクセスできず、新規会員登録画面に遷移する' do
    subject { current_path }

    it 'ホーム画面' do
      visit posts_path
      is_expected.to eq '/users/sign_in'
    end
    it '検索画面' do
      visit search_path
      is_expected.to eq '/users/sign_in'
    end
    it '投稿詳細画面' do
      visit post_path(post)
      is_expected.to eq '/users/sign_in'
    end
    it '投稿編集画面' do
      visit edit_post_path(post)
      is_expected.to eq '/users/sign_in'
    end
  end

  describe '他人の投稿詳細画面のテスト' do
    before do
      sign_in(user)
      visit post_path(other_post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + other_post.id.to_s
      end
      it 'ユーザー画像・名前のリンク先が正しい' do
        expect(page).to have_link other_post.user.name, href: user_path(other_post.user)
      end
      it '投稿のtitleが表示される' do
        expect(page).to have_content other_post.title
      end
      it '投稿のtextが表示される' do
        expect(page).to have_content other_post.text
      end
    end

    context '他人のマイページの確認' do
      before do
        visit user_path(other_user)
      end

      it '他人の名前とmbti、紹介文が表示される' do
        expect(page).to have_content other_user.name
        expect(page).to have_content other_user.mbti
        expect(page).to have_content other_user.introduction
      end
      it 'フォローリンクが表示される' do
        expect(page).to have_link 'フォロー', href: user_relationships_path(other_user)
      end
      it '他人のユーザー編集画面へのリンクは存在しない、他人のユーザーの通報リンクが表示される' do
        find(".three-point-contents").click
        expect(page).not_to have_link '編集する', href: edit_user_path(other_user)
        expect(page).to have_link '通報する', href: new_user_report_path(other_user)
      end
      it '自分のユーザー編集画面へのリンクは存在しない' do
        expect(page).not_to have_link '編集する', href: edit_user_path(user)
      end
      it '投稿一覧に他人の投稿のtitleが表示され、リンクが正しい' do
        expect(page).to have_link other_post.title, href: post_path(other_post)
      end
      it '投稿一覧に他人の投稿のtextが表示される' do
        expect(page).to have_content other_post.text
      end
      it '自分の名前、紹介文は表示されない' do
        expect(page).not_to have_content user.name
        expect(page).not_to have_content user.introduction
      end
      it '自分の投稿は表示されない' do
        expect(page).not_to have_content post.title
        expect(page).not_to have_content post.text
      end
    end

    context '他人の投稿編集画面' do
      it '遷移できず、投稿一覧画面にリダイレクトされる' do
        visit edit_post_path(other_post)
        expect(current_path).to eq '/posts'
      end
    end

    context '他人のユーザー編集画面' do
      it '遷移できず、自分のマイページにリダイレクトされる' do
        visit edit_user_path(other_user)
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end
