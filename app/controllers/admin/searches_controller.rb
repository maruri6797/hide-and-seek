class Admin::SearchesController < ApplicationController
  def search
    @tags = Tag.all

  end

  def result
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @users = User.looks(params[:search], @word)
    else
      @posts = Post.looks(params[:search], @word)
    end
  end
end
