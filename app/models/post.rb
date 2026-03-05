class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :replies, class_name: "Post", foreign_key: "reply_to_id", dependent: :destroy
  has_many :quotes, class_name: "Post", foreign_key: "quote_id", dependent: :destroy
  belongs_to :reply_to, class_name: "Post", optional: true
  belongs_to :quote, class_name: "Post", optional: true

  validates :body, presence: true, length: { maximum: 140 }
end
