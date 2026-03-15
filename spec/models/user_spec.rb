require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "name,email,passwordがあれば有効である" do
      user = create(:user)
      expect(user).to be_valid
    end
    it "nameがなければ無効であること" do
      user = build(:user, name: nil)
      expect(user).to_not be_valid
    end

    it "emailがなければ無効である" do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it "passwordがなければ無効である" do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end
  end

  describe "リレーション" do
    it "ユーザー削除で投稿も削除されること" do
      user = create(:user)
      create(:post, user: user)
      expect { user.destroy }.to change(Post, :count).by(-1)
    end

    it "ユーザー削除でいいねも削除されること" do
      user = create(:user)
      create(:like, user: user)
      expect { user.destroy }.to change(Like, :count).by(-1)
    end

    it "ユーザー削除でフォローも削除されること" do
      user = create(:user)
      create(:follow, follower: user)
      expect { user.destroy }.to change(Follow, :count).by(-1)
    end

    it "ユーザー削除でフォロワーも削除されること" do
      user = create(:user)
      create(:follow, followed: user)
      expect { user.destroy }.to change(Follow, :count).by(-1)
    end
  end
end
