class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_active?
  before_action :delete_post, only: [:show]
  before_action :ensure_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "投稿しました。"
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    # 画像の削除
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.images.find(image_id)
        image.purge
      end
    end
    if @post.update(post_params)
      @post.update(status: 1)
      redirect_to post_path(@post), notice: "投稿を編集しました。"
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def index
    @posts = Post.where.not(status: 2).page(params[:page]).per(10).order(created_at: :desc)
    @follow_posts = @posts.where(user_id: [current_user.id, *current_user.follower_ids])
    @post = Post.new
  end

  def show
    @post = @posts.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, post_id: @post.id)
      current_user.view_count.create(post_id: @post.id)
    end
    @post_comment = PostComment.new
    @action = current_user.actions.new
  end

  def delete
    pos = Post.find(params[:id])
    pos.update(status: 2)
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :status, images: [], tag_ids: [])
  end

  def ensure_user
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to posts_path, notice: "このユーザーでは画面遷移できません。"
    elsif @post.status == "edited"
      redirect_to post_path(@post), notice: "編集済みのため画面遷移できません。"
    elsif @post.status == "deleted"
      redirect_to posts_path, notice: "削除済みです。"
    end
  end

  def delete_post
    @posts = Post.where.not(status: 2)
  end

  def user_active?
    if current_user.is_deleted == true
      redirect_to user_logout_path(current_user)
    end
  end
end