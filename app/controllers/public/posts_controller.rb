class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "投稿しました。"
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    # 画像の削除
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.images.find(image_id)
        image.purge
      end
    end
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿を編集しました。"
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, images: [], tag_ids: [])
  end
end
