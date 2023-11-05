class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { in: 1..20 }
  validates :introduction, length: { maximum: 200 }

  has_many :favorites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :view_count, dependent: :destroy
  has_many :stars, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :reports, as: :target
  # フォロー機能
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :relationships, source: :followed
  has_many :followeds, through: :reverse_of_relationships, source: :follower
  # 通知機能
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  # 通報機能
  has_many :reporters, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reporteds, class_name: "Report", foreign_key: "reported_id", dependent: :destroy

  has_one_attached :profile_image

  enum mbti: { INTJ:0, INTP:1, ENTJ:2, ENTP:3, INFJ:4, INFP:5, ENFJ:6, ENFP:7, ISTJ:8, ISFJ:9, ESTJ:10, ESFJ:11, ISTP:12, ISFP:13, ESTP:14, ESFP:15, unknown: 16 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      case mbti
      when "INTJ" then
        file_path = Rails.root.join('app/assets/images/INTJ.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "INTP" then
        file_path = Rails.root.join('app/assets/images/INTP.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ENTJ" then
        file_path = Rails.root.join('app/assets/images/ENTJ.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ENTP" then
        file_path = Rails.root.join('app/assets/images/ENTP.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "INFJ" then
        file_path = Rails.root.join('app/assets/images/INFJ.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "INFP" then
        file_path = Rails.root.join('app/assets/images/INFP.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ENFJ" then
        file_path = Rails.root.join('app/assets/images/ENFJ.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ENFP" then
        file_path = Rails.root.join('app/assets/images/ENFP.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ISTJ" then
        file_path = Rails.root.join('app/assets/images/ISTJ.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ISFJ" then
        file_path = Rails.root.join('app/assets/images/ISFJ.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ESTJ" then
        file_path = Rails.root.join('app/assets/images/ESTJ.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ESFJ" then
        file_path = Rails.root.join('app/assets/images/ESFJ.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ISTP" then
        file_path = Rails.root.join('app/assets/images/ISTP.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ISFP" then
        file_path = Rails.root.join('app/assets/images/ISFP.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ESTP" then
        file_path = Rails.root.join('app/assets/images/ESTP.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "ESFP" then
        file_path = Rails.root.join('app/assets/images/ESFP.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      when "unknown" then
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id)
  end

  def following?(user)
    followers.include?(user)
  end

  # フォロー通知
  def create_notification_follow(current_user)
    record = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if record.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # adminのuser検索
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where(["name like(?) or id like(?)", "#{word}", "#{word}"])
    elsif search == "forward_match"
      @user = User.where("name like(?)", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name like(?)", "%#{word}")
    elsif search == "partical_match"
      @user = User.where("name like(?)", "%#{word}%")
    end
  end

# ゲストログイン
  GUEST_USER_EMAIL = "guest@example.com"
  GUEST_USER_MBTI = "unknown"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL, mbti: GUEST_USER_MBTI) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  def active_for_authentication?
    super && (is_deleted == 'false')
  end
end