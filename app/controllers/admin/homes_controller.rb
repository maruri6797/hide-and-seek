class Admin::HomesController < ApplicationController
  def top
    @users = User.page(params[:page]).per(10).order(created_at: :asc)
  end
end
