class Admin::SearchesController < ApplicationController
  def search
    @tags = Tag.all

  end

  def result
    @range = params[:range]
    @word = params[:word]
    if @word == ""
      redirect_to admin_search_path, notice: "検索ワードを入力して下さい。"
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = Post.joins(:post_tags).where(post_tags: {tag_id: @tag.id})
    elsif @range == "User"
      @users = User.looks(params[:search], @word)
    elsif @range == "Post"
      @posts = Post.looks(params[:search], @word)
    end
  end
end
