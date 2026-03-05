class PostsController < ApplicationController
   before_action :authenticate_user!
  def index
    @posts = Post.all.includes(:user, :images).order(created_at: :desc)
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
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private

  def post_params
    params.require(:post).permit(:body, :reply_to_id, :quote_id)
  end
end
