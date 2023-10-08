class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @nitifications = current_user.passive_notifications
    # @notifications.where(checked: false).each do |notification|
    #   notification.update(checked: true)
    # end
  end
end
