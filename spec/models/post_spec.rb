require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーション" do
    it "bodyがあれば有効であること" do
      post = create(:post)
      expect(post).to be_valid
    end

    it "bodyが空なら無効であること" do
      post = build(:post, body: "")
      expect(post).not_to be_valid
    end

    it "140文字なら有効であること" do
      post = build(:post, body: "a"*140)
      expect(post).to be_valid
    end

    it "141文字以上は無効であること" do
      post = build(:post, body: "a"*141)
      expect(post).to_not be_valid
    end
  end

  describe "リレーション" do
      it "userと紐づいていなければ無効であること" do
        post = build(:post, user: nil)
        expect(post).to_not be_valid
      end

      it "投稿を削除するといいねも削除されること" do
        post = create(:post)
        create(:like, post: post, user: create(:user))
        expect { post.destroy }.to change(Like, :count).by(-1)
      end

      it "投稿を削除すると画像も削除すること" do
        post = create(:post)
        create(:image, post: post)
        expect { post.destroy }.to change(Image, :count).by(-1)
      end
    end
  end
