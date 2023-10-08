class SearchesController < ApplicationController
  def search

  end

  def result
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page])
    if params[:word] == ""
      redirect_to search_path
    else
      @posts = Post.looks(params[:word]).page(params[:page])
    end
  end
end
