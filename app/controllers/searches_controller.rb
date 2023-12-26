class SearchesController < ApplicationController
  before_action :authenticate_user!
    before_action :user_active?


  def search
    @tags = Tag.all
    @posts = Post.where.not(status: 2).page(params[:page]).order(created_at: :desc)
    @post = Post.new
    @q = @posts.ransack(params[:q])
  end

  def result
    @posts = Post.where.not(status: 2)
    @keywords = params[:q][:title_or_text_cont].split(/[\p{blank}\s]+/)
    grouping_hash = @keywords.reduce({}){|hash, word| hash.merge(word => { title_or_text_cont: word })}
    @q = @posts.ransack({ combinator: 'and', groupings: grouping_hash })
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @posts.joins(:post_tags).where(post_tags: {tag_id: @tag.id})
    else
      redirect_to search_path if @keyword == ""
      @posts = @q.result(distinct: true)
    end
  end

  private

  def user_active?
    if current_user.is_deleted == true
      reset_session
      redirect_to root_path, notice: "退会されているため操作できません。"
    end
  end
end