class Post < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true, length: { maximum: 500 }

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :notifications, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  has_many :stars, dependent: :destroy

  enum status: { active: 0, edited: 1, deleted: 2 }

  has_many_attached :images

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def stared_by?(user)
    stars.exists?(user_id: user.id)
  end

  # いいね通知
  def create_notification_favorite(current_user)
    record = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    if record.blank?
      notification = current_user.active_notifications.new(
        visited_id: user_id,
        post_id: id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.is_checked = true
      end
      notification.save if notification.valid?
    end
  end
  # コメント通知
  def create_notification_comment(current_user)
    notification = current_user.active_notifications.new(
      visited_id: user_id,
      post_id: id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.is_checked = true
    end
    notification.save if notification.valid?
  end

  # adminのpost検索
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title like or text like", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("title like or text like", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title like or text like", "%#{word}")
    elsif search == "partical_match"
      @post = Post.where("title like or text like", "%#{word}%")
    end
  end
end
