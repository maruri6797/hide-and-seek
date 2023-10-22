require 'rails_helper'

describe '[STEP3] 仕上げのテスト' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }
  
  describe 'サクセスメッセージのテスト' do
    subject { page }
    
    it 'ユーザー新規登録成功時' do
      visit new_user_registration_path
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 4)
      fill_in 'user[mbti]', with: 'INTJ'
      fill_in 'user[email]', with: 'a' + user.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規会員登録'
      is_expected.to have_content 'アカウント'
    end
    it 'ユーザーログイン成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      is_expected.to have_content 'ログイン'
    end
    it 'ユーザーログアウト成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      visit destroy_user_session_path, method: :delete
      is_expected.to have_content 'ログアウト'
    end
    it 'ユーザーのプロフィール情報更新成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      visit edit_user_path(user)
      click_button '保存'
      is_expected.to have_content '編集しました'
    end
    it '投稿データの新規登録成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      visit new_post_path
      fill_in 'post[title]', with: Faker::Lorem.characters(number: 10)
      fill_in 'post[text]', with: Faker::Lorem.characters(number: 30)
      click_button '投稿する'
      is_expected.to have_content '投稿'
    end
  end
  
  describe '処理失敗時のテスト' do
    context 'ユーザー新規登録失敗: nameを0文字にする' do
      before do
        visit new_user_registration_path
        @name = ''
        @mbti = 'INTP'
        @email = 'a' + user.email
        fill_in 'user[name]', with: @name
        fill_in 'user[mbti]', with: @mbti
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
        expect(page).to have_selector 'user[mbti]', with: @mbti
        expect(page).to have_field 'user[email]', with: @email
      end
      it 'バリデーションエラーが表示される' do
        click_button '新規会員登録'
        expect(page).to have_content "1文字以上で入力して下さい"
      end
    end
    
    context 'ユーザーのプロフィール情報編集失敗: nameを0文字にする' do
      before do
        @name = ''
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
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
    
    context '投稿データの新規投稿失敗: titleを空にする' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit new_post_path
        @text = Faker::Lorem.characters(number: 29)
        fill_in 'post[text]', with: @text
      end
      
      it '投稿が保存されない' do
        expect { click_button '投稿する' }.not_to change(Post.all, :count)
      end
      it '新規投稿画面を表示しており、フォームの内容が正しい' do
        click_button '投稿する'
        expect(page).to have_content '投稿する'
        expect(find_field('post[title]').text).to be_blank
        expect(page).to have_field 'post[text]', with: @text
      end
      it 'バリデーションエラーが表示される' do
        click_button '投稿する'
        expect(page).to have_content "必須項目です"
      end
    end
    
    context '投稿データの更新失敗: titleを空にする' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit edit_post_path(post)
        @post_old_title = post.title
        fill_in 'post[title]', with: ''
        click_button '変更して投稿する'
      end
      
      it '投稿が更新されない' do
        expect(post.reload.title).to eq @book_old_title
      end
      it '投稿編集画面を表示しており、フォームの内容が正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
        expect(find_field('post[title]').text).to be_blank
        exoect(page).to have_field 'post[text]', with: post.text
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_content '必須項目です'
      end
    end
  end
  
  describe 'ログインしていない場合のアクセス制限のテスト: アクセスできず、新規会員登録画面に遷移する' do
    subject { current_path }
    
    
  end
end