require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        is_expected.to eq false
      end
    end

    context 'textカラム' do
      it '空欄でないこと' do
        post.text = ''
        is_expected.to eq false
      end
      it '500文字以下であること: 500文字は〇' do
        post.text = Faker::Lorem.characters(number: 500)
        is_expeccted.to eq true
      end
      it '500文字以下であること: 501文字は×' do
        post.text = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end