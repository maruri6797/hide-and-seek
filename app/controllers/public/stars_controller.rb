class Public::StarsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_active?

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
  
  private
  
  def user_active?
    if current_user.is_deleted == true
      reset_session
      redirect_to root_path, notice: "退会されているため操作できません。"
    end
  end
end
