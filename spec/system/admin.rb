require 'rails_helper'

RSpec.describe "adminのテスト", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }

  before do
    @admin = FactoryBot.create(:admin)
    visit '/admin/sign_in'
    fill_in 'admin[email]', with: @admin.email
    fill_in 'admin[password]', with: @admin.password
    click_button 'ログイン'
  end

  # describe 'ログイン後のテスト' do
  #   context 'リンクの内容を確認' do
  #     it 'ログイン後の遷移先が、会員一覧画面になる' do
  #       expect(current_path).to eq '/admin'
  #     end
  #     it 'ユーザー一覧リンクが表示される' do
  #       expect(page).to have_link 'ユーザー一覧', href: "/admin"
  #     end
  #     it '検索リンクが表示される' do
  #       expect(page).to have_link '検索', href: "/admin/search"
  #     end
  #     it '投稿一覧リンクが表示される' do
  #       expect(page).to have_link '投稿一覧', href: "/admin/posts"
  #     end
  #     it '通報一覧リンクが表示される' do
  #       expect(page).to have_link '通報一覧', href: "/admin/reports"
  #     end
  #     it 'タグ一覧リンクが表示される' do
  #       expect(page).to have_link 'タグ一覧', href: "/admin/tags"
  #     end
  #     it 'ログアウトリンクが表示される' do
  #       expect(page).to have_link 'ログアウト', href: "/admin/sign_out"
  #     end
  #   end
  # end

  # describe 'ユーザー一覧画面のテスト' do
  #   before do
  #     visit admin_root_path
  #   end

  #   context '表示内容の確認' do
  #     it '「ユーザー一覧」と表示される' do
  #       expect(page).to have_content 'ユーザー一覧'
  #     end
  #     it 'ユーザーidが表示される' do
  #       expect(page).to have_content user.id
  #       expect(page).to have_content other_user.id
  #     end
  #     it 'ユーザー名が表示される' do
  #       expect(page).to have_link user.name, href: admin_user_path(user)
  #       expect(page).to have_link other_user.name, href: admin_user_path(other_user)
  #     end
  #     it 'メールアドレスが表示される' do
  #       expect(page).to have_content user.email
  #       expect(page).to have_content other_user.email
  #     end
  #   end
  # end

  # describe 'ユーザー詳細画面のテスト' do
  #   before do
  #     visit admin_user_path(user)
  #   end

  #   context '表示内容の確認' do
  #     it 'user.nameさんのユーザー詳細と表示される' do
  #       expect(page).to have_content user.name + 'さんのユーザー詳細'
  #     end
  #     it '「編集する」リンクが表示される：URLが正しい' do
  #       expect(page).to have_link '編集する', href: "/admin/users/" + user.id.to_s + "/edit"
  #     end
  #     it 'userのidが表示される：' do
  #       expect(page).to have_content user.id
  #     end
  #     it 'userのユーザー名が表示される：other_userは表示されない' do
  #       expect(page).to have_content user.name
  #       expect(page).not_to have_content other_user.name
  #     end
  #     it 'userのメールアドレスが表示される：other_userは表示されない' do
  #       expect(page).to have_content user.email
  #       expect(page).not_to have_content other_user.email
  #     end
  #     it 'userの投稿が表示される：other_userは表示されない' do
  #       expect(page).to have_content post.title
  #       expect(page).not_to have_content other_post.title
  #     end
  #   end
  # end

  # describe 'ユーザー編集画面のテスト' do
  #   before do
  #     visit edit_admin_user_path(user)
  #   end

    # context '表示内容の確認' do
    #   it '「user.nameさんのユーザー情報編集」が表示される' do
    #     expect(page).to have_content user.name + "さんのユーザー情報編集"
    #   end
    #   it 'ユーザー名編集フォームにuserの名前が表示される' do
    #     expect(page).to have_field 'user[name]', with: user.name
    #   end
    #   it 'メールアドレス編集フォームにuserのメールアドレスが表示される' do
    #     expect(page).to have_field 'user[email]', with: user.email
    #   end
    #   it 'ライセンス編集フォームが表示される' do
    #     expect(page).to have_field 'user[is_license]'
    #   end
    #   it 'ステータス編集フォームが表示される' do
    #     expect(page).to have_field 'user[is_deleted]'
    #   end
    #   it '変更を保存ボタンが表示される' do
    #     expect(page).to have_button '変更を保存'
    #   end
    # end

  #   context '更新成功のテスト' do
  #     before do
  #       @user_old_name = user.name
  #       @user_old_email = user.email
  #       @user_old_license = user.is_license
  #       @user_old_status = user.is_deleted
  #       fill_in 'user[name]', with: Faker::Lorem.characters(number: 4)
  #       fill_in 'user[email]', with: @user_old_email + 'a'
  #       choose 'user[is_license]', with: true
  #       choose 'user[is_deleted]', with: true
  #       click_button '変更を保存'
  #       save_page
  #     end

  #     it 'nameが正しく更新される' do
  #       expect(user.reload.name).not_to eq @user_old_name
  #     end
  #     it 'emailが正しく更新される' do
  #       expect(user.reload.email).not_to eq @user_old_email
  #     end
  #     it 'is_licenseが正しく更新される' do
  #       expect(user.reload.is_license).not_to eq @user_old_license
  #     end
  #     it 'is_deletedが正しく更新される' do
  #       expect(user.reload.is_deleted).not_to eq @user_old_status
  #     end
  #     it 'リダイレクト先が、userの詳細画面になっている' do
  #       expect(current_path).to eq '/admin/users/' + user.id.to_s
  #     end
  #   end
  # end

  # 検索

  # describe '投稿一覧画面のテスト' do
  #   before do
  #     visit admin_posts_path
  #   end

  #   context '表示内容の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/admin/posts'
  #     end
  #     it 'ユーザー名が表示される' do
  #       expect(page).to have_content user.name
  #       expect(page).to have_content other_user.name
  #     end
  #     it 'タイトルが表示される' do
  #       expect(page).to have_content post.title
  #       expect(page).to have_content other_post.title
  #     end
  #   end
  # end
  
  describe '投稿詳細画面のテスト' do
    before do
      visit admin_post_path(post)
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/posts/' + post.id.to_s
      end
      
    end
  end
end