class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :create, :destroy ]

  def create
    if @like.save
      redirect_to post_path(@post), notice: "いいねをしました"
    else
      redirect_to post_path(@post), alert: "いいねできませんできた"
    end
  end

  def destroy
    @like = current_user.likes.find_by(post: @post)
    @like.destroy
    redirect_to post_path(@post), notice: "いいねを取り消しました"
  end


private

def set_post
   @post = Post.find(params[:post_id])
end
end
