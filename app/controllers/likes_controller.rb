class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: [ :create, :destroy ]

  def create
    if @like.save
      redirect_to post_path(@post), notice: "いいねをしました"
    else
      redirect_to post_path(@post), alert: "いいねできませんできた"
    end
  end

  def destroy
    @like.destroy
    redirect_to post_path(@post), notice: "いいねを取り消しました"
  end


private

def set_like
   @post = Post.find(params[:post_id])
   @like = current_user.likes.build(post: @post)
end
end
