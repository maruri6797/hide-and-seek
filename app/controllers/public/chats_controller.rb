class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_non_related, only: [:show]

  def show
    @user = User.find(params[:id])
    room = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: room)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    if UserRoom.where(user_id: current_user.id, room_id: params[:chat][:room_id]).present?
      @chat = Chat.create(params.require(:chat).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
      @room = @chat.room
      @room.create_notification_message(current_user, @chat.id)
    redirect_to request.referer
    else
      redirect_back
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  # 相互フォローか確認
  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to posts_path
    end
  end
end