class PostsController < ApplicationController
   before_action :authenticate_user!
  def index # 自身のポストとフォローしている人のポストを表示する
    following_ids = current_user.following.ids
    @posts = Post.where(user_id: [ *following_ids, current_user.id ])
            .includes(:user, :images)
            .order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end


  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "投稿を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:body, :reply_to_id, :quote_id)
  end
end
