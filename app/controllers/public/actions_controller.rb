class Public::ActionsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    post_comment = PostComment.find(params[:post_comment_id])
    @action = Action.create(user_id: current_user.id, post_id: post.id, post_comment_id: post_comment.id, face_type: params[:face_type])
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    post_comment = PostComment.find(params[:post_comment_id])
    action = Action.find_by(user_id: current_user.id, post_id: post.id, post_comment_id: post_comment.id)
    action.destroy
    redirect_to request.referer
  end
end