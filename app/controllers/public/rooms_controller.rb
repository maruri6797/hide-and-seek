class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

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
end