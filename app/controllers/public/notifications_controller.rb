class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_active?

  def index
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
    @notifications.where(is_checked: false).each do |notification|
      notification.update(is_checked: true)
    end
  end
  
  private
  
  def user_active?
    if current_user.is_deleted == true
      reset_session
      redirect_to root_path, notice: "退会されているため操作できません。"
    end
  end
end
