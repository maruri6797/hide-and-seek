class Public::StarsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    star = current_user.stars.new(post_id: @post.id)
    star.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    star = current_user.stars.find_by(post_id: @post.id)
    star.destroy
  end
end
