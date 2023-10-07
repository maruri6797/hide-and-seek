class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, uniqueness: true, length: { in: 1..20 }
  validates :introduction, length: { maximum: 200 }

  has_many :favorites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :rooms, through: :user_room, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :view_count, dependent: :destroy
  # フォロー機能
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :relationships, source: :followed
  has_many :followeds, through: :reverse_of_relationships, source: :follower
  # 通知機能
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  has_one_attached :profile_image

  enum mbti: { INTJ:1, INTP:2, ENTJ:3, ENTP:4, INFJ:5, INFP:6, ENFJ:7, ENFP:8, ISTJ:9, ISFJ:10, ESTJ:11, ESFJ:12, ISTP:13, ISFP:14, ESTP:15, ESFP:16, unknown: 17 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
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
    record = Notification.where(["visitor_id = ?, visited_id = ?, action = ?", current_user.id, id, 'follow'])
    if record.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid
    end
  end

  # DM通知
  def create_notification_message(current_user, chat_id, visited_id)
    notification = current_user.active_notifications.new(
      room_id: room_id,
      chat_id: chat_id,
      visited_id: id,
      visitor_id: current_user.id,
      action: 'dm'
    )
    notification.save if notification.valid?
  end

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
end
