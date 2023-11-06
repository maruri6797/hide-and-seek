class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_active?

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
    @post.create_notification_comment(current_user)
    respond_to :js
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.find_by(post_id: @post.id)
    comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def user_active?
    if current_user.is_deleted == true
      reset_session
      redirect_to root_path, notice: "退会されているため操作できません。"
    end
  end
end
