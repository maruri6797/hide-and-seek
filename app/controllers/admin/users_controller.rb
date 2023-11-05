class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @active_posts = @user.posts.where(status: 0)
    @edited_posts = @user.posts.where(status: 1)
    @deleted_posts = @user.posts.where(status: 2)
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      if @user.is_deleted == true
        @user.posts.update(status: 2)
        reset_session
      end
      redirect_to admin_user_path(@user), notice: "ユーザー情報を編集しました。"
    else
      flash.now[:alert] = "ユーザー情報の編集に失敗しました。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted, :is_license)
  end
end
