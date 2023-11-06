class Public::UsersController < ApplicationController
  before_action :user_active?
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update, :check, :stars]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.where.not(status: 2).order(created_at: :desc)
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    stars = Star.where(user_id: @user.id).pluck(:post_id)
    @star_posts = Post.find(stars)
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def followings
    user = User.find(params[:id])
    @users = user.followers
  end

  def followers
    user = User.find(params[:id])
    @users = user.followeds
  end

  def favorites
    user = User.find(params[:id])
    favorites = Favorite.where(user_id: user.id).pluck(:post_id)
    @posts = Post.find(favorites)
  end

  def stars
    user = User.find(params[:id])
    stars = Star.where(user_id: user.id).pluck(:post_id)
    @posts = Post.find(stars)
  end

  def check
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を編集しました。"
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path, notice: "退会しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :mbti, :introduction, :is_deleted, :profile_image, :favorie)
  end

  def ensure_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user), notice: "このユーザーでは画面遷移できません。"
    end
  end

  def user_active?
    if current_user.is_deleted == true
      redirect_to destroy_user_session_path, method: :delete
    end
  end
end
