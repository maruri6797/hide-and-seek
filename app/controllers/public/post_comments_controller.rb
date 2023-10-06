class Public::PostCommentsController < ApplicationController
  def create
    po = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = po.id
    comment.save
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
