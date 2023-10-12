class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿を削除しました。"
  end
end
