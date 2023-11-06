class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_active?

  def index
    @current_user_rooms = current_user.rooms
    myRoomIds= []
    @current_user_rooms.each do |current_user_room|
      myRoomIds << current_user_room.id
    end
    @user_rooms = UserRoom.where(room_id: myRoomIds).where.not(user_id: current_user.id)
  end

  def lists
    @users = current_user.followers
  end
  
  private
  
  def user_active?
    if current_user.is_deleted == true
      reset_session
      redirect_to root_path, notice: "退会されているため操作できません。"
    end
  end
end