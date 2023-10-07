class Public::RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:relationship][:follower_id])
    current_user.follow(@user)
    @user.create_notification_follow(current_user)
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
end
