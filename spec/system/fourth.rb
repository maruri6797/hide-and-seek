require 'rails_helper'

RSpec.describe "[STEP4]各機能のテスト", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }
  let!(:favorite) { create(:favorite, post: other_post, user: user) }

  before do
    sign_in(user)
  end

  context 'relationshipのテスト' do
    it 'ユーザーのフォロー、フォロー解除' do
      visit user_path(other_user)
      click_link 'フォロー'
      expect(page).to have_link 'フォロー解除', href: user_relationships_path(other_user)
      expect(other_user.followeds.count).to eq(1)
      expect(user.followers.count).to eq(1)
      click_link 'フォロー解除'
      expect(page).to have_link 'フォロー', href: user_relationships_path(other_user)
      expect(other_user.followeds.count).to eq(0)
      expect(user.followers.count).to eq(0)
    end
  end

  context 'favoriteのテスト' do
    it '投稿へのいいね解除リンクが正しい' do
      visit post_path(other_post)
      expect(page).to have_link "", href: post_favorites_path(other_post)
      expect(page).to have_selector '.fa-solid.fa-heart'
    end
    it '投稿へのいいねリンクが正しい' do
      visit post_path(post)
      expect(page).to have_link "", href: post_favorites_path(post)
      expect(page).to have_selector '.fa-regular.fa-heart'
    end
    it 'いいねした投稿が表示される' do
      visit favorites_user_path(user)
      expect(page).to have_content other_post.title
      expect(page).not_to have_content post.title
    end
  end
  # お気に入りも機能としては同様のためスキップ
  # コメント、いいねお気に入り共に非同期のためテストが複雑 selenium???

  context 'DMのテスト' do
    before do
      visit user_path(other_user)
      click_link 'フォロー'
      visit user_path(user)
      find('.three-point').click
      click_link 'ログアウト'

      sign_in(other_user)
      visit user_path(user)
      click_link 'フォロー'
    end

    it '通知画面に通知が表示される' do
      visit notifications_path
      expect(page).to have_link user.name, href: user_path(user)
      expect(page).to have_content 'あなたをフォローしました'
    end
    it '手紙のリンクが表示される' do
      expect(page).to have_link "", href: chat_path(user)
      expect(page).to have_selector '.fa-envelope'
    end
    it 'チャットルームに入ることができる：表示内容が正しい' do
      page.all(".fa-envelope")[1].click
      expect(current_path).to eq '/chats/' + user.id.to_s
      expect(page).to have_content user.name
      expect(page).to have_field 'chat[message]'
      expect(page).to have_selector '.fa-paper-plane'
    end
    it 'メッセージを送信できる：表示される' do
      page.all(".fa-envelope")[1].click
      fill_in 'chat[message]', with: 'test'
      find('.submit').click
      expect(page).to have_content 'test'
    end
    it 'DM一覧画面に送信履歴が表示される' do
      page.all(".fa-envelope")[1].click
      fill_in 'chat[message]', with: 'testmessage'
      find('.submit').click
      visit rooms_path
      expect(page).to have_link user.name, href: user_path(user)
      expect(page).to have_link 'testmessage', href: chat_path(user)
    end
    it '最後に送ったメッセージが表示される' do
      page.all(".fa-envelope")[1].click
      fill_in 'chat[message]', with: 'test'
      find('.submit').click
      fill_in 'chat[message]', with: 'message'
      find('.submit').click
      visit rooms_path
      expect(page).to have_link 'message', href: chat_path(user)
    end
  end

  context 'DMの受信・送信のテスト：通知含む' do
    before do
      visit user_path(other_user)
      click_link 'フォロー'
      visit user_path(user)
      find('.three-point').click
      click_link 'ログアウト'

      sign_in(other_user)
      visit user_path(user)
      click_link 'フォロー'
      page.all(".fa-envelope")[1].click
      fill_in 'chat[message]', with: 'test'
      find('.submit').click
      visit user_path(other_user)
      find('.three-point').click
      click_link 'ログアウト'

      sign_in(user)
    end

    it 'ヘッダーの通知に赤い丸が表示される' do
      expect(page).to have_selector '.visually-hidden'
    end
    it '通知一覧画面に行くと、赤い丸が消える' do
      visit notifications_path
      expect(page).not_to have_selector '.visually-hidden'
    end
    it '通知一覧画面に、通知が表示される' do
      visit notifications_path
      expect(page).to have_link other_user.name, href: user_path(other_user)
      expect(page).to have_link 'メッセージ', href: chat_path(other_user)
      expect(page).to have_content 'test'
    end
    it '通知からDM画面に遷移できる：URLが正しい' do
      visit notifications_path
      click_link 'メッセージ'
      expect(current_path).to eq '/chats/' + other_user.id.to_s
    end
    it '相手の名前・メッセージが表示される' do
      visit chat_path(other_user)
      expect(page).to have_content other_user.name
      expect(page).to have_content 'test'
    end
    it 'メッセージを送信できる' do
      visit chat_path(other_user)
      fill_in 'chat[message]', with: 'reply'
      find('.submit').click
      expect(page).to have_content 'reply'
    end
  end
end
