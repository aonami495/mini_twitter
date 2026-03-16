require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "ログイン済みでindexにアクセスしたら200が返ること" do
      user = create(:user)
      sign_in user
      get posts_path
      expect(response).to have_http_status(200)
    end

    it "未ログインでindexにアクセスしたらリダイレクトされること" do
      create(:user)
      get posts_path
      expect(response).to have_http_status(302)
    end
  end

  describe "POST /posts" do
    before do
      @user = create(:user)
      sign_in @user
    end
    it "投稿を作成したらDBに保存されること" do
     expect { post posts_path, params: { post: { body: "テスト投稿" } } }
     .to change(Post, :count).by(1)
    end

    it "空のbodyでは投稿できないこと" do
      build(:post, body: "")
      post posts_path
      expect(response).to have_http_status(400)
    end
  end

  describe "DELETE /post/:id" do
    it "他人の投稿は削除できないこと" do
      user = create(:user)
      sign_in user
      other_post = create(:post, user: create(:user))
      expect { delete post_path(other_post) }.not_to change(Post, :count)
    end
  end
end
