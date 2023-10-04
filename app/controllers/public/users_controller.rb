class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit, :check]

  def index
  end

  def show
  end

  def edit
  end

  def followings
  end

  def followers
  end

  def favorites
  end

  def check
  end

  def update
  end

  def leave
    user = User.find(params[:id])
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会しました。"
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :mbti, :introduction, :is_deleted, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーでは画面遷移できません。"
    end
  end
end
