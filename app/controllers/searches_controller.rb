class SearchesController < ApplicationController
  def search
    @tags = Tag.all
  end

  def result
    @keyword = params[:keyword]
    @tag = Tag.find(params[:tag_id])
    if @tag.present?
      @posts = @tag.posts.page(params[:page])
    else
      redirect_to search_path if @keyword == ""
      @posts = Post.where("title like :word or text like :word", word: "%#{@keyword}%")
    end
  end
end
