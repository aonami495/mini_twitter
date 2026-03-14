

FactoryBot.define do
factory :post do
  body { "テスト投稿です" }
  association :user
end
end
