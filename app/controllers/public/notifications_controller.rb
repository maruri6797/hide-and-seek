class Public::NotificationsController < ApplicationController
  def index
    @nitifications = current_user.passive_notifications.page(params[:page])
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
