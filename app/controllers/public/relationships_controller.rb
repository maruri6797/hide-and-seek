class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user.id)
    @user.create_notification_follow(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id]).destroy
    redirect_to request.referer
  end
end
