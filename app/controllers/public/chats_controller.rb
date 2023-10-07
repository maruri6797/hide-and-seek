class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_romms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    
    unless user_rooms.nill?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room_id)
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    room = @chat.room
    room.create_notification_message(current_user.id, @chat.id, room.user.id)
    redirect_to requiest.referer
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
