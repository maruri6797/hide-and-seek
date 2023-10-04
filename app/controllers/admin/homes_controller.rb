class Admin::HomesController < ApplicationController
  def top
    @users = User.order(created_at: :asc).page(params[:page])
  end
end
