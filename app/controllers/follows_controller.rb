class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :create, :destroy ]

  def create
    @follow = current_user.active_follows.build(followed: @user)
    if @follow.save
      redirect_to user_path(@user), notice: "#{@user.name}をフォローしました"
    else
      redirect_to user_path(@user), alert: "フォローに失敗ました"
    end
  end

def destroy
  @follow = current_user.active_follows.find_by(followed: @user)
  @follow.destroy
  redirect_to user_path(@user)
end

private
def set_user
  @user = User.find(params[:user_id])
end
end
