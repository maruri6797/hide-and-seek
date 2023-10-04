class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.all
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to request.referer, notice: "タグを追加しました。"
    else
      flash.now[:alert] = "タグの追加に失敗しました。"
      @tags = Tag.all
      render :index
    end
  end
  
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to request.referer, notice: "タグを削除しました。"
  end
  
  private
  
  def tag_params
    params.require(:tag).permit(:name)
  end
end
