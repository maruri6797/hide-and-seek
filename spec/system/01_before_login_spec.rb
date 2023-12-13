require 'rails_helper'
require 'selenium-webdriver'

describe '[STEP1]ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it '新規登録リンクが表示される: 青色のボタンの表示が「新規登録」である' do
        expect(page).to have_button("新規登録")
      end
  #     it '新規登録リンクの内容が正しい' do
  #       sign_up_link = find_all('a')[4].text
  #       expect(page).to have_link sign_up_link, href: new_user_registration_path
  #     end
  #     it 'ゲストログインリンクが表示される: 灰色のボタンの表示が「ゲストログイン」である' do
  #       guest_sign_in_link = find_all('a')[7].text
  #       expect(guest_sign_in_link).to match(/ゲストログイン/)
  #     end
  #     it 'ゲストログインリンクの内容が正しい' do
  #       guest_sign_in_link = find_all('a')[7].text
  #       expect(page).to have_link guest_sign_in_link, href: users_guest_sign_in_path
  #     end
  #     it 'ログインリンクが表示される: 緑色のボタンの表示が「ログイン」である' do
  #       log_in_link = find_all('a')[4].text
  #       expect(log_in_link).to match(/ログイン/)
  #     end
  #     it 'ログインリンクの内容が正しい' do
  #       log_in_link = find_all('a')[4].text
  #       expect(page).to have_link log_in_link, href: new_user_session_path
  #     end
  #   end
  # end

  # describe 'About画面のテスト' do
  #   before do
  #     visit '/about'
  #   end

  #   context '表示内容の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/abount'
  #     end
  #   end
  # end

  # describe 'ヘッダーのテスト: ログインしていない場合' do
  #   before do
  #     visit root_path
  #   end

  #   context '表示内容の確認' do
  #     it 'Hide-and-seekリンクが表示される: 左上から1番目のリンクが「Hide-and-seek」である' do
  #       top_link = find_all('a')[0].text
  #       expect(top_link).to match(/'logo.jpg'/)
  #     end
  #     it 'Aboutリンクが表示される: 左上から2番目のリンクが「About」である' do
  #       about_link = find_all('a')[1].text
  #       expect(about_link).to match(/About/)
  #     end
  #     it 'お問い合わせリンクが表示される: 左上から3番目のリンクが「お問い合わせ」である' do
  #       contact_link = find_all('a')[2].text
  #       expect(contact_link).to match(/お問い合わせ/)
  #     end
  #     # it '新規登録リンクが表示される: 上2段目の左から1番目のリンクが「」である' do
  #     #   signup_link = find_all('a')[3].text
  #     #   expect(signup_link).to match(//)
  #     # end
  #     it 'ゲストログインリンクが表示される: 上2段目の左から2番目のリンクが「ゲストログイン」である' do
  #       guestlogin_link = find_all('a')[4].text
  #       expect(guestlogin_link).to match(/ゲストログイン/)
  #     end
  #   end

  #   context 'リンクの内容を確認' do
  #     subject { current_path }

      # it 'Hide-and-seekを押すと、トップ画面に遷移する' do
      #   top_link = find_all('a')[0].text
      #   top_link = top_link.delete(' ')
      #   top_link.gsub!(/\n/, '')
      #   click_link top_link
      #   is_expected.to eq '/'
      # end
  #     it 'Aboutを押すと、アバウト画面に遷移する' do
  #       about_link = find_all('a')[1].text
  #       about_link = about_link.delete(' ')
  #       about_link.gsub!(/\n/, '')
  #       click_link about_link
  #       is_expected.to eq '/about'
  #     end
  #     it '新規登録を押すと、新規登録画面に遷移する' do
  #       signup_link = find_all('a')[2].text
  #       signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
  #       click_link signup_link, match: :first
  #       is_expected.to eq ' /users/sign_up'
  #     end
  #   end
  # end

  # describe 'ユーザー新規登録のテスト' do
  #   before do
  #     visit new_user_registration_path
  #   end

  #   context '表示内容の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/users/sign_up'
  #     end
  #     it '「新規会員登録」と表示される' do
  #       expect(page).to have_content '新規会員登録'
  #     end
  #     it 'nameフォームが表示される' do
  #       expect(page).to have_field 'user[name]'
  #     end
  #     it 'mbtiボタンが表示される' do
  #       expect(page).to have_selector 'user[mbti]'
  #     end
  #     it 'emailフォームが表示される' do
  #       expect(page).to have_field 'user[email]'
  #     end
  #     it 'passwordフォームが表示される' do
  #       expect(page).to have_field 'user[password]'
  #     end
  #     it 'password_confirmationフォームが表示される' do
  #       expect(page).to have_field 'user[password_confirmation'
  #     end
  #     it '新規会員登録ボタンが表示される' do
  #       expect(page).to have_button '新規会員登録'
  #     end
  #   end

  #   context '新規会員登録成功のテスト' do
  #     before do
  #       fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
  #       fill_in 'user[mbti]', with: 'INTJ'
  #       fill_in 'user[email]', with: Faker::Internet.email
  #       fill_in 'user[password]', with: 'password'
  #       fill_in 'user[password_confirmation]', with: 'password'
  #     end
  #     it '正しく新規会員登録される' do
  #       expect { click_button '新規会員登録' }.to change(User.all, :count).by(1)
  #     end
  #     it '新規会員登録後のリダイレクト先が、ホーム画面になっている' do
  #       click_button '新規会員登録'
  #       expect(current_path).to eq '/posts'
  #     end
  #   end
  # end

  # describe 'ユーザーログイン' do
  #   let(:user) { create(:user) }

  #   before do
  #     visit new_user_session_path
  #   end

  #   context '表示内容の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/users/sign_in'
  #     end
  #     it '「ログイン」と表示される' do
  #       expect(page).to have_content 'ログイン'
  #     end
  #     it 'emailフォームが表示される' do
  #       expect(page).to have_field 'user[email]'
  #     end
  #     it 'passwordフォームが表示される' do
  #       expect(page).to have_field 'user[password]'
  #     end
  #     it 'ログインボタンが表示される' do
  #       expect(page).to have_button 'ログイン'
  #     end
  #   end

  #   context 'ログイン成功のテスト' do
  #     before do
  #       fill_in 'user[email]', with: user.email
  #       fill_in 'user[password', with: user.password
  #       click_button 'ログイン'
  #     end

  #     it 'ログイン後のリダイレクト先が、ホーム画面になっている' do
  #       expect(current_path).to eq '/posts'
  #     end
  #   end

  #   context 'ログイン失敗のテスト' do
  #     before do
  #       fill_in 'user[email]', with: ''
  #       fill_in 'user[password]', with: ''
  #       click_button 'ログイン'
  #     end

  #     it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
  #       expect(current_path).to eq '/users/sign_in'
  #     end
  #   end
  # end

  # describe 'ヘッダーのテスト: ログインしている場合' do
  #   let(:user) { create(:user) }

  #   before do
  #     visit new_user_session_path
  #     fill_in 'user[email]', with: user.email
  #     fill_in 'user[password]', with: user.password
  #     click_button 'ログイン'
  #   end

  #   context 'ヘッダーの表示を確認' do
  #     it 'Hide-and-seekリンクが表示される: 左上から1番目のリンクが「Hide-and-seek」である' do
  #       top_link = find_all('a')[0].text
  #       expect(top_link).to match(/'logo.jpg'/)
  #     end
  #     it 'Aboutリンクが表示される: 左上から2番目のリンクが「About」である' do
  #       about_link = find_all('a')[1].text
  #       expect(about_link).to match(/About/)
  #     end
  #     it 'お問い合わせリンクが表示される: 左上から3番目のリンクが「お問い合わせ」である' do
  #       contact_link = find_all('a')[2].text
  #       expect(contact_link).to match(/お問い合わせ/)
  #     end
      # it 'ホームリンクが表示される: 上2段目の左から1番目のリンクが「」である' do
      #   posts_link = find_all('a')[3].text
      #   expect(posts_link).to match(//)
      # end
      # it '検索リンクが表示される: 上2段目の左から2番目のリンクが「」である' do
      #   search_link = find_all('a')[4].text
      #   expect(search_link).to match(//)
      # end
      # it 'マイページリンクが表示される: 上2段目の左から3番目のリンクが「」である' do
      #   user_link = find_all('a')[5].text
      #   expect(user_link).to match(//)
      # end
      # it '通知リンクが表示される: 上2段目の左から4番目のリンクが「」である' do
      #   notifications_link = find_all('a')[6].text
      #   expect(notifications_link).to match(//)
      # end
      # it 'DMリンクが表示される: 上2段目の左から5番目のリンクが「」である' do
      #   rooms_link = find_all('a')[7].text
      #   expect(rooms_link).to match(//)
      # end
    end
  end
end