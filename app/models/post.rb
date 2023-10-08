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

  has_many_attached :images

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
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
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  # コメント通知
  def create_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      visited_id: visited_id,
      post_id: id,
      comment_id: comment_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
