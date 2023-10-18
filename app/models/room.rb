class Room < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reactions, dependent: :destroy

    # DM通知
  def create_notification_message(current_user, chat_id)
    @current_user = UserRoom.where(room_id: id).where.not(user_id: current_user.id)
    @user = @current_user.find_by(room_id: id)
    notification = current_user.active_notifications.new(
      room_id: id,
      chat_id: chat_id,
      visited_id: @user.user_id,
      action: 'dm'
    )
    notification.save if notification.valid?
  end
end
