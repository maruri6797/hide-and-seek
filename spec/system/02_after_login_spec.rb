require 'rails_helper'

describe '[STEP2]ユーザーログイン後のテスト' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザーログアウトのテスト』でテスト済みになります' do
      subject { current_path }

      it 'ホームを押すと、投稿一覧画面に遷移する' do
        posts_link = find_all('a')[3].text
        posts_link = posts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link posts_link
        is_expected.to eq '/posts'
      end
      it '検索を押すと、検索画面に遷移する' do
        search_link = find_all('a')[4].text
        search_link = search_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link search_link
        is_expected.to eq '/search'
      end
      it 'マイページを押すと、ユーザー詳細画面に遷移する' do
        user_link = find_all('a')[5].text
        user_link = user_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link user_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it '通知を押すと、通知一覧画面に遷移する' do
        notifications_link = find_all('a')[6].text
        notifications_link = notifications_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link notifications_link
        is_expected.to eq '/notifications'
      end
      it 'DMを押すと、DM一覧画面に遷移する' do
        rooms_link = find_all('a')[7].text
        rooms_link = rooms_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link rooms_link
        is_expected.to eq '/rooms'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
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
    end

    context '投稿成功のテスト' do
      before do
        visit new_post_path
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
    end

    context '投稿成功のテスト' do
      before do
        visit new_post_path
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'post[text]', with: Faker::Lorem.characters(number: 30)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿する' }.to change(user.posts, :count).by(1)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        second_user_post = FactoryBot.create(:post, user: user)
        visit post_path(second_user_post)
        click_link '編集する'
        expect(current_path).to eq edit_post_path(second_user_post)
      end
    end

    context '削除リンクのテスト' do
      before do
        visit delete_post_path(post)
      end
      it '正しく削除される' do
        expect(Post.where(id: post.id).status).to eq "deleted"
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
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

    end
  end

end