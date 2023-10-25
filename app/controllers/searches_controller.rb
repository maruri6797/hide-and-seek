class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @tags = Tag.all
    @posts = Post.where.not(status: 2).page(params[:page]).order(created_at: :desc)
    @post = Post.new
  end

  def result
    @posts = Post.where.not(status: 2)
    @keyword = params[:keyword]
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @posts.joins(:post_tags).where(post_tags: {tag_id: @tag.id})
    else
      redirect_to search_path if @keyword == ""
      @posts = @posts.where("title like :word or text like :word", word: "%#{@keyword}%")
    end
  end
end