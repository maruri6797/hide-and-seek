class Public::ActionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_comment = PostComment.find(params[:post_comment_id])
    @action = current_user.actions.new(action_params)
    @action.post_comment_id = @post_comment.id
    @action.save
  end

  def destroy
    @post_comment = PostComment.find(params[:post_comment_id])
    @action = current_user.actions.find_by(post_comment_id: @post_comment)
    @action.destroy
  end
end
